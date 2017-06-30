class CheckInsController < ApplicationController
  layout 'customers'
  before_action :set_current_tile

  def index
    if params[:store_id]
      index_for_store_admin
    else
      index_for_patrons
    end
  end

  def index_for_store_admin
    @store = Store.find(params[:store_id])
    @check_ins = @store.check_ins.order('created_at DESC')
    @patrons = @store.patrons

    render :index, layout: 'store_admin'
  end

  def index_for_patrons
    @store = Store.find(params[:store_id])
    @check_ins = @store.check_ins.order('created_at DESC')
    @patrons = @store.patrons
  end

  def ask_for_location
    @check_in = CheckIn.new
  end

  def create
    permitted_params = check_in_params
    @check_in = CheckIn.new(permitted_params)
    if @check_in.save
      logger.info " #{self.class.to_s}##{__method__.to_s}: status == #{@check_in.status}"
      case @check_in.status
      when :completed_punch
        render :success
      
      when :enroll_patron

        @check_in_id = @check_in.id
        @new_patron = Patron.new(phone_number: @check_in.phone_number)
        render :new_patron

      when :ambiguous_store
        render :ambiguous_store
      else
        ap "else"
      end 
    else
      render :ask_for_location
    end
  end

  def create_patron
    #Enroll the new patron.
    logger.info " #{self.class.to_s}##{__method__.to_s}"
    patron_params = enrollment_params.except(:check_in_id)
    check_in_id = enrollment_params[:check_in_id]
    @new_patron = Patron.new(patron_params)
    @check_in = CheckIn.find(check_in_id)
    if @new_patron.save
      @check_in.update_attribute(:patron, @new_patron)
      case @check_in.status
      when :completed_punch
        render :success

      when :ambiguous_store
        render :ambiguous_store
      else
        ap "else"
      end
    else
      render :ask_for_location
    end

    #flash[:message] = "Success"
  end

  def select_store
    check_in_id = params[:check_in_id]
    store_id = params[:store]

    @check_in = CheckIn.find(check_in_id)
    @check_in.update_attribute(:store_id, store_id)
    @check_in.save

    render 'success'  

  end

  private
    # Rails 4+ requires parameter whitelisting.
    def check_in_params
      params.require(:check_in).permit(:phone_number, :lat, :lng)
    end

    def enrollment_params
      logger.info " #{self.class.to_s}##{__method__.to_s}"
      params.require(:patron).permit(:check_in_id, :phone_number, :first_name, :last_name)
    end

    def ambiguous_store_params
      #params.require(:parameters).permit(:store)
    end

  # Helps toggle the store admin title buttons
  #  so they have a "clicked" appearance.
  #  Refactor: This method is repeated in several controllers.
  def set_current_tile
    @clicked_tile = "check_ins"
  end

end