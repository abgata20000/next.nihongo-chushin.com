class Icon < ActiveHash::Base
  include SupportActiveHash

  field :name

  create(id: 0, name: "default")
  59.times do |i|
    id = i + 1
    create(id: id, name: "icon_#{id}")
  end

  def url
    "/icon/#{name}.png"
  end


end
