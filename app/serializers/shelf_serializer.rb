class ShelfSerializer
  include JSONAPI::Serializer
  attributes :id, :capacity, :code, :number_of_books 

  attribute :books do |shelf|
    shelf.books.map do |book|
      {
        id: book.id,
        title: book.title
      }
    end
  end
end
