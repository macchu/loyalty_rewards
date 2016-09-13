class ImageTool
  require 'mini_magick'

  # Resize a given MiniMagick object.
  #
  # Ex: 
  #      image = MiniMagick::Image.open("http://example.com/image.jpg")
  #      image = ImageTool.resize(image, 1/4)
  def self.resize(image, ratio)
    puts ratio
    new_width = image.width * ratio
    new_height = image.height * ratio
    puts new_width
    puts new_height
    image.resize "#{new_width.floor}x#{new_height.floor}"
  end

  def self.overlay_image(base, top, x, y, output)
    result = base.composite(top) do |c|
      c.compose "Over"    # OverCompositeOp
      c.geometry "+#{x}+#{y}" # copy second_image onto first_image from (20, 20)
    end
    result.write output
  end
end