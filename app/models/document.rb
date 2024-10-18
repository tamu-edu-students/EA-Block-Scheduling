# app/models/document.rb
class Document < ApplicationRecord
  has_one_attached :file
end
