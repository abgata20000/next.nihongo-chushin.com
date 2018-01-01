class Language < ActiveHash::Base
  include SupportActiveHash

  field :key
  field :name

  create(id: 1, key: 'ja', name: "日本語")
  create(id: 2, key: 'en', name: "英語")

end
