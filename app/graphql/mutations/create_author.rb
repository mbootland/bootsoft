class Mutations::CreateAuthor < GraphQL::Schema::Mutation
  null true

  argument :author, Types::AuthorInputType, required: true

  # Probably not the most secure way
  def resolve(author:)
    Author.create author.to_h
  end
end