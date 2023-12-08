# README

This website will host my digital CV and Blog, amongst other things.



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
    UpdatedAt

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
