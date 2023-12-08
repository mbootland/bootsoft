# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject

    field :create_author, Types::AuthorType, mutation: Mutations::CreateAuthor

    field :update_author, Boolean, null: false, description: "Update an author" do
      argument :author, Types::AuthorInputType, required: true
    end

    def update_author(author:)
      record = Author.find(author[:id])

      record&.update author.to_h
    end

    field :delete_author, Boolean, null: false, description: "Delete an author" do
      argument :id, ID, required: true
    end

    def delete_author(id:)
      Author.find(id).destroy
    end
  end
end
