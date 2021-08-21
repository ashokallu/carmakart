module Mutations::Customers
  class Create < Mutations::BaseMutation

    graphql_name 'CustomerCreate'

    # Each 'argument' method call defines a variable to be given as argument for the #resolve method call.

    argument :first_name, GraphQL::Types::String,
             required: true,
             description: 'The first name for the customer'

    argument :last_name, GraphQL::Types::String,
             required: true,
             description: 'The last name for the customer'

    field :customer,
          Types::Customers::CustomerType,
          null: true,
          description: "description of the customer object"
    field :errors, [String], null: true

    # The #resolve method should return a hash whose symbols match the field names.
    def resolve(args)
      # binding.pry
      customer = Customer.new(first_name: args[:first_name], last_name: args[:last_name])
      if customer.save
        {
          customer: customer,
          errors: []
        }
      else
        # Failed save, return the errors to the client
        {
          first_name: nil,
          errors: comment.errors.full_messages
        }
      end
    end
  end
end