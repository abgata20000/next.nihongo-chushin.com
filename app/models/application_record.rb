class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  extend Enumerize
  extend ActiveHash::Associations::ActiveRecordExtensions

  private

  def now
    Time.zone.now
  end
end
