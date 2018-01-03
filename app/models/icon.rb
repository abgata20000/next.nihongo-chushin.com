class Icon < ActiveHash::Base
  include SupportActiveHash

  field :name

  create(id: 0, name: "default")
  58.times do |i|
    id = i + 2
    create(id: id, name: "icon_#{id}")
  end

  def icon_class(current_user)
    class_arr = ['color', 'icon']
    if current_user && current_user.icon == name
      class_arr << 'selected'
    end
    class_arr.join(' ')
  end

  def url
    "/images/icon/#{name}.png"
  end
end
