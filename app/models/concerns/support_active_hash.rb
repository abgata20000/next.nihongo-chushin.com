module SupportActiveHash
  extend ActiveSupport::Concern

  class_methods do
    def to_array
      all.map(&:name)
    end
  end
end
