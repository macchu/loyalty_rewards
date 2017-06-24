module HeroPagesHelpers
  def generate_image_tag(image_name)
    zero_or_one = rand(2)
    if zero_or_one == 0
      return true
    else
      return false
    end
  end
end
