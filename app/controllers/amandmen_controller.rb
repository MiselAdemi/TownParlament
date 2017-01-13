class AmandmenController < ApplicationController
  before_action :set_amandman, only: [:show, :edit, :update, :destroy]

  # GET /amandmen
  # GET /amandmen.json
  def index
    @amandmen = Amandman.all
  end

  # GET /amandmen/1
  # GET /amandmen/1.json
  def show
    @act = Act.find(@amandment.owner_id)
    redirect_to @act
  end

  # GET /amandmen/new
  def new
    @amandman = Amandman.new
    @meeting = Meeting.find(1)
  end

  # GET /amandmen/1/edit
  def edit
  end

  # POST /amandmen
  # POST /amandmen.json
  def create
    @amandman = Amandman.new(amandman_params)
    @amandment.user = current_user

    respond_to do |format|
      if @amandman.save
        format.html { redirect_to @amandman, notice: 'Amandman was successfully created.' }
        format.json { render :show, status: :created, location: @amandman }
      else
        format.html { render :new }
        format.json { render json: @amandman.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amandmen/1
  # PATCH/PUT /amandmen/1.json
  def update
    respond_to do |format|
      if @amandman.update(amandman_params)
        format.html { redirect_to @amandman, notice: 'Amandman was successfully updated.' }
        format.json { render :show, status: :ok, location: @amandman }
      else
        format.html { render :edit }
        format.json { render json: @amandman.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amandmen/1
  # DELETE /amandmen/1.json
  def destroy
    @amandman.destroy
    respond_to do |format|
      format.html { redirect_to amandmen_url, notice: 'Amandman was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amandman
      @amandman = Amandman.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amandman_params
      params.require(:amandment).permit(:date, :content, :explanation, :rating, :act_id, :owner_id)
    end
end
