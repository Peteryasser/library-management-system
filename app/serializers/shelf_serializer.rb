class ShelfSerializer
  include JSONAPI::Serializer
  attributes :id, :capacity, :code, :number_of_books 
end
