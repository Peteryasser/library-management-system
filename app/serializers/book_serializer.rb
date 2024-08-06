class BookSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :rating, :review_count, :stock

  attribute :author do |book|
    {
      id: book.author.id,
      name: book.author.name,
      date_of_birth: book.author.date_of_birth
    }
  end

  attribute :shelf do |book|
    {
      id: book.shelf.id,
      capacity: book.shelf.capacity,
      code: book.shelf.code,
      number_of_books: book.shelf.number_of_books
    }
  end

  attribute :categories do |book|
    book.categories.map do |category|
      {
        id: category.id,
        name: category.name
      }
    end
  end
end
