class Types::AuthorType < Types::BaseObject
  description "One Author"

  field :id, ID, null: false
  field :first_name, String, null: false
  field :last_name, String, null: false
  field :yob, Int, null: false
  field :is_alive, Boolean, null: false

  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  field :full_name, String, null: false
  field :full_name_reversed, String, null: false


  # Testing various ways of doing things below

  # Alternative to Author class definition
  def full_name_reversed
    "#{object.last_name} #{object.first_name}"
  end

  # Custom Types Test
  field :coordinates, Types::CoordinatesType, null: false

  # Int Array Type Test
  field :publication_years, [Int], null: false
end

class Types::AuthorInputType < GraphQL::Schema::InputObject
  graphql_name "AuthorInputType"
  description "All the attributes needed to create an author"

  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :yob, Int, required: false
  argument :is_alive, Boolean, required: false
end