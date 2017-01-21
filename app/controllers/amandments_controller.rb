class AmandmentsController < ApplicationController
  before_action :set_amandmant, only: [:show, :edit, :update, :destroy]

  # GET /amandmen
  # GET /amandmen.json
  def index
    @amandments = Amandment.all
  end

  # GET /amandmen/1
  # GET /amandmen/1.json
  def show
    @act = Act.find(@amandment.owner_id)
    redirect_to @act
  end

  # GET /amandmen/new
  def new
    @amandment = Amandment.new
    @meeting = Meeting.find(1)
  end

  # GET /amandmen/1/edit
  def edit
  end

  # POST /amandmen
  # POST /amandmen.json
  def create
    @amandment = Amandment.new(amandmant_params)
    @amandment.user = current_user

    respond_to do |format|
      if @amandment.save
        format.html { redirect_to @amandment, notice: 'Amandman was successfully created.' }
        format.json { render :show, status: :created, location: @amandment }
      else
        format.html { render :new }
        format.json { render json: @amandment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amandmen/1
  # PATCH/PUT /amandmen/1.json
  def update
    respond_to do |format|
      if @amandment.update(amandmant_params)
        format.html { redirect_to @amandment, notice: 'Amandman was successfully updated.' }
        format.json { render :show, status: :ok, location: @amandment }
      else
        format.html { render :edit }
        format.json { render json: @amandment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amandmen/1
  # DELETE /amandmen/1.json
  def destroy
    client = Connection::MarkLogic.new.client
    client.send_corona_request("/v1/documents?uri=/amandments/amandment_#{@amandment.id}.xml", :delete)
    @amandment.destroy
    respond_to do |format|
      format.html { redirect_to home_meeting_path, notice: 'Amandman was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amandmant
      @amandment = Amandment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amandmant_params
      params.require(:amandment).permit(:date, :content, :explanation, :rating, :act_id, :owner_id)
    end
end
