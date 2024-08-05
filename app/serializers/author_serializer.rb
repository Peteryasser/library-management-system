class AuthorSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :date_of_birth

  attribute :books do |author|
    author.books.map do |book|
      {
        id: book.id,
        title: book.title
      }
    end
  end
end
