local function readInput()
	local fName = arg[1]
	if not fName then
		print("Please provide a file name.\nExample: lua main.lua test.xml")
		os.exit(1)
	end
	return fName
end

local function read_file(fName)
	local file, err = io.open(fName, "r")
	if not file then
		print(err)
		os.exit(1)
	end
	return file
end

function Attributes(k, v)
	return {
		key = k,
		value = v,
	}
end

local function parse_attributes(line, idx)
	local key, val = "", ""
	-- parse the key
	while idx <= #line do
		if line:sub(idx, idx) == " " then
			print("Key of attributes cannot have spaces")
			os.exit(1)
		end
		if line:sub(idx, idx) == "=" then
			idx = idx + 1
			break
		end
		key = key .. line:sub(idx, idx)
		idx = idx + 1
	end
	-- parse the value
	if line:sub(idx, idx) ~= '"' then
		print("Value of attributes must start with double quotes.")
		os.exit(1)
	end
	idx = idx + 1
	while idx <= #line do
		if line:sub(idx, idx) == '"' then
			if line:sub(idx, idx + 1) ~= '">' then
				print("Invalid Syntax for attributes.")
				os.exit(1)
			end
			break
		end
		val = val .. line:sub(idx, idx)
		idx = idx + 1
	end
	return Attributes(key, val), idx
end

local function parse_start_element(line, idx)
	local data, att = "", nil
	while idx <= #line do
		if line:sub(idx, idx) == " " then
			att, idx = parse_attributes(line, idx + 1)
			break
		end
		if line:sub(idx, idx) == ">" then
			break
		end
		data = data .. line:sub(idx, idx)
		idx = idx + 1
	end
	return data, att, idx
end

local function parse_end_element(line, idx)
	local data = ""
	while idx <= #line do
		if line:sub(idx, idx) == " " then
			print("Error: End elements cannot have spaces.")
			os.exit(1)
		end
		if line:sub(idx, idx) == ">" then
			break
		end
		data = data .. line:sub(idx, idx)
		idx = idx + 1
	end
	return data
end

local function parse_character(line, idx)
	local data = ""
	while idx <= #line do
		if line:sub(idx, idx) == "<" then
			break
		end
		if line:sub(idx, idx) == ">" then
			print("Error: Character data contains '>' tag")
			os.exit(1)
		end
		data = data .. line:sub(idx, idx)
		idx = idx + 1
	end
	return data
end

local function parse_and_print(line)
	local i = 1
	while i <= #line do
		if line:sub(i, i) == " " then
			goto continue
		else
			if line:sub(i, i + 1) == "</" then
				local data = parse_end_element(line, i + 2)
				print("End element:", data)
				i = i + 2 + #data
				goto continue
			end
			if line:sub(i, i) == "<" then
				local data, attributes, lastIdx = parse_start_element(line, i + 1)
				print("Start element:", data)
				i = lastIdx
				if attributes then
					local att = string.format("{'%s':'%s'}", attributes.key, attributes.value)
					print("Attributes:", att)
					i = i + 1
				end
				goto continue
			end
			-- else the event is a character data
			local data = parse_character(line, i)
			print("Character data:", data)
			i = i + #data - 1
		end
		::continue::
		i = i + 1
	end
end

function Main()
	local fName = readInput()
	local file = read_file(fName)
	for line in file:lines() do
		parse_and_print(line)
	end
end

Main()
