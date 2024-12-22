Definitely not the best way to write a xml parser.

This was just me learning and playing around with Lua.  

Try:

```
lua main.lua test.xml
```
Results:

```
Start element:  bookstore
Start element:  book
Attributes:     {'category':'COOKING'}
Start element:  title
Attributes:     {'lang':'en'}
Character data: Everyday Italian
End element:    title
Start element:  author
Character data: Giada De Laurentiis
End element:    author
Start element:  year
Character data: 2005
End element:    year
Start element:  price
Character data: 30.00
End element:    price
End element:    book
Start element:  book
Attributes:     {'category':'CHILDREN'}
Start element:  title
Attributes:     {'lang':'en'}
Character data: Harry Potter
End element:    title
Start element:  author
Character data: J K. Rowling
End element:    author
Start element:  year
Character data: 2005
End element:    year
Start element:  price
Character data: 29.99
End element:    price
End element:    book
Start element:  book
Attributes:     {'category':'WEB'}
Start element:  title
Attributes:     {'lang':'en'}
Character data: Learning XML
End element:    title
Start element:  author
Character data: Erik T. Ray
End element:    author
Start element:  year
Character data: 2003
End element:    year
Start element:  price
Character data: 39.95
End element:    price
End element:    book
End element:    bookstore
```
