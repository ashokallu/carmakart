module Types::Customers
  class CustomerType < Types::BaseObject
    graphql_name 'Customer'

    field :id, GraphQL::Types::Int, null: false,
          description: 'ID of the customer.'

    field :first_name, GraphQL::Types::String, null: false,
          description: 'The first name of the customer'

    field :last_name, GraphQL::Types::String, null: false,
          description: 'The last name of the customer'

    field :created_at, Types::TimeType, null: false,
          description: 'Timestamp of the customer creation.'

    field :updated_at, Types::TimeType, null: false,
          description: "Timestamp of the customer's last activity."
  end
end