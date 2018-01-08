class Sound < ActiveHash::Base
  include SupportActiveHash

  field :name

  # create(id: 0, name: "default")
  5.times do |i|
    id = i + 1
    create(id: id, name: "beep_#{id}")
  end

  create(id: 99, name: "silent")

  def url
    "/sound/#{name}.mp3"
  end
end
