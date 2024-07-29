class AuthorSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :date_of_birth
end
