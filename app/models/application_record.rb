class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  extend Enumerize
  extend ActiveHash::Associations::ActiveRecordExtensions
end
