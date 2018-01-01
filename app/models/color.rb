class Color < ActiveHash::Base
  include SupportActiveHash

  field :name
  field :text_color
  field :color_code

  create(name: "darkgoldenrod", text_color: '#FFF', color_code: false)
  create(name: "sandybrown", text_color: '#FFF', color_code: false)
  create(name: "tan", text_color: '#FFF', color_code: false)
  create(name: "darkslategray", text_color: '#FFF', color_code: false)
  create(name: "limegreen", text_color: '#FFF', color_code: false)
  create(name: "lightgreen", text_color: '#404040', color_code: false)
  create(name: "EFB435", text_color: '#FFF', color_code: true)
  create(name: "gray", text_color: '#FFF', color_code: false)
  create(name: "black", text_color: '#FFF', color_code: false)
  create(name: "f8b500", text_color: '#FFF', color_code: true)
  create(name: "CDC673", text_color: '#FFF', color_code: true)
  create(name: "DDA0DD", text_color: '#FFF', color_code: true)
  create(name: "FFD700", text_color: '#FFF', color_code: true)
  create(name: "cadetblue", text_color: '#FFF', color_code: false)
  create(name: "slateblue", text_color: '#FFF', color_code: false)
  create(name: "royalblue", text_color: '#FFF', color_code: false)
  create(name: "green", text_color: '#FFF', color_code: false)
  create(name: "purple", text_color: '#FFF', color_code: false)
  create(name: "navy", text_color: '#FFF', color_code: false)
  create(name: "lightcoral", text_color: '#FFF', color_code: false)
  create(name: "pink", text_color: '#666', color_code: false)
  create(name: "red", text_color: '#FFF', color_code: false)
  create(name: "darkred", text_color: '#FFF', color_code: false)
  create(name: "crimson", text_color: '#FFF', color_code: false)
  create(name: "peru", text_color: '#FFF', color_code: false)
  create(name: "chocolate", text_color: '#FFF', color_code: false)
  create(name: "sienna", text_color: '#FFF', color_code: false)
  create(name: "teal", text_color: '#FFF', color_code: false)
  create(name: "008db7", text_color: '#FFF', color_code: true)
  create(name: "darkorange", text_color: '#FFF', color_code: false)
  create(name: "deeppink", text_color: '#FFF', color_code: false)
  create(name: "84c1ff", text_color: '#FFF', color_code: true)
  create(name: "ff7fff", text_color: '#FFF', color_code: true)
  create(name: "ffff7f", text_color: '#001e43', color_code: true)
  create(name: "ffbf7f", text_color: '#FFF', color_code: true)
  create(name: "00608d", text_color: '#FFF', color_code: true)
  create(name: "9f166a", text_color: '#FFF', color_code: true)
  create(name: "dc6b9a", text_color: '#FFF', color_code: true)
  create(name: "dc6b9a", text_color: '#FFF', color_code: true)
  create(name: "eb6ea0", text_color: '#FFF', color_code: true)
  create(name: "6e4a55", text_color: '#FFF', color_code: true)
  create(name: "3cb37a", text_color: '#FFF', color_code: true)
  create(name: "bccddb", text_color: '#9370DB', color_code: true)
  create(name: "288c66", text_color: '#FFF', color_code: true)
  create(name: "0075c2", text_color: '#FFF', color_code: true)
  create(name: "00a1e9", text_color: '#FFF', color_code: true)
  create(name: "ea5549", text_color: '#FFF', color_code: true)
  create(name: "d70035", text_color: '#FFF', color_code: true)
  create(name: "6c2735", text_color: '#FFF', color_code: true)
  create(name: "9d8e87", text_color: '#FFF', color_code: true)
  create(name: "946c45", text_color: '#FFF', color_code: true)
  create(name: "ffedab", text_color: '#656565', color_code: true)

  def color
    return "##{name}" if color_code
    name
  end
end
