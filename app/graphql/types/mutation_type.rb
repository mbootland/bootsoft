# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject

    # # Moved, keeping for reference.
    # field :create_author, Types::AuthorType, null: true, description: "Create an Author" do
    #   argument :first_name, String, required: true
    #   argument :last_name, String, required: true
    #   argument :yob, Int, required: true
    #   argument :is_alive, Boolean, required: true
    # end

    # # Deleted and move, keeping for reference.
    # def create_author(**author_attributes)
    #   Author.create(author_attributes)
    # end

    field :create_author, Types::AuthorType, mutation: Mutations::CreateAuthor
  end
end
