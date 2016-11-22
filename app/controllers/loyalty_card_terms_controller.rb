class LoyaltyCardTermsController < ApplicationController
  def edit
    @terms = LoyaltyCardTerm.find(params[:id])
  end

  def show
    @terms = LoyaltyCardTerm.find(params[:loyalty_card_term_id])
  end

  def update
    @terms = LoyaltyCardTerm.find(params[:loyalty_card_term][:id])
    if @terms.update(loyalty_card_terms_parameters)
      flash[:success] =  "Terms successfully changed."
      redirect_to edit_loyalty_card_terms_path(@terms)
    else
      flash[:error] = "There was a problem."
      render :edit
    end

  end

  private
  # Rails 4+ requires parameter whitelisting.
  def loyalty_card_terms_parameters
    params.require(:loyalty_card_term).permit(:id, :reward_description, :stamps_required)
  end
end