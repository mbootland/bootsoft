# README

This website will host my digital CV and Blog, amongst other things.


GraphQL Usage:

GraphQL Endpoint:
http://bootsoft.net:3000/graphql

Quering An Author and specifying results:

{
  author(id: 5){
    id
    firstName
    lastName
    isAlive
    yob

    createdAt
    updatedAt

    fullName
    fullNameReversed
    coordinates {
      latitude
      longitude
    }
    publicationYears
  }
}

Returning All Authors:

{
  authors {
    fullName
  }
}

When creating an Author:

mutation {
  createAuthor(firstName: "First", lastName: "Last", yob:1988, isAlive: true) {
    id
    fullName
  }
}

Input Type Variables:

mutation createAuthor($author: AuthorInputType!) {
  createAuthor(author: $author) {
    id
    fullName
  }
}

{
  "author": {
  	"firstName":"Connie",
  	"lastName":"Tester",
  	"yob":1945,
  	"isAlive":true
	}
}

Update Author:

mutation UpdateAuthor($author: AuthorInputType!) {
  updateAuthor(author: $author)
}

{
  "author": {
    "id": "22",
    "firstName": "Connie",
    "lastName": "Tester",
    "yob": 1945,
    "isAlive": true
  }
}

Delete Author:

mutation {
  deleteAuthor(id: "21")
}
