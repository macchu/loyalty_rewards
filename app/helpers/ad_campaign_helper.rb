module AdCampaignHelper
  def randomize_check()
    zero_or_one = rand(2)
    if zero_or_one == 0
      '<i class="fa fa-check">'.html_safe
    else

    end
  end 
end