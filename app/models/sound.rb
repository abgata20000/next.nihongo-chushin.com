class Sound < ActiveHash::Base
  include SupportActiveHash

  field :name

  5.times do |i|
    id = i + 1
    create(name: "beep_#{id}")
  end

  create(name: "silent")

  def url
    "/sound/#{name}.mp3"
  end
end
