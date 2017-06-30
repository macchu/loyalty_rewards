module ApplicationHelper
  def flash_class(level)
    case level
      when "notice"
       "alert alert-info"
      when "success"
        "alert alert-success"
      when "error"
        "alert alert-danger"
      when "alert"
        "alert alert-danger"
    end
  end

  def determine_if_tile_is_clicked(tile_title, current_tile)
    if tile_title == current_tile
      "clicked"
    else
      ""
    end
  end
end
