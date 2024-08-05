class CategorySerializer
  include JSONAPI::Serializer
  attributes :id, :name

  attribute :books do |category|
    category.books.map do |book|
      {
        id: book.id,
        title: book.title
      }
    end
  end

end
