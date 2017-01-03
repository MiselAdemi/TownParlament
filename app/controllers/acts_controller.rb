class ActsController < ApplicationController
  before_action :set_act, only: [:show, :edit, :update, :destroy]

  # GET /acts
  # GET /acts.json
  def index
    @acts = Act.all
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
    @akt = Act.find(params[:id])
    @akt.status="approved"
    @akt.save
    @client = Connection::MarkLogic.client
    @akt_xml = Transform::ToXml.transform(@akt)

    @client.send_corona_request("/v1/documents?database=Tim23&uri=/test/#{@akt.name}.xml", :put, @akt_xml.to_s)

    @act = @client.send_corona_request("/v1/documents?database=Tim23&uri=/test/#{@akt.name}.xml")
    @act  = Nokogiri::XML(@act)
  end

  # GET /acts/new
  def new
    @act = Act.new
  end

  # GET /acts/1/edit
  def edit
  end

  # POST /acts
  # POST /acts.json
  def create
    @act = Act.new(act_params)

    if @act.save
      redirect_to @act, notice: 'Act was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    if @act.update(act_params)
      redirect_to @act, notice: 'Act was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /acts/1
  # DELETE /acts/1.json
  def destroy
    @akt = Act.find(params[:id])
    @client = Connection::MarkLogic.client
    @client.send_corona_request("/v1/documents?database=Tim23&uri=/test/#{@akt.name}.xml", :delete)
    @act.destroy
    redirect_to acts_url, notice: 'Act was successfully destroyed.'
  end

  def create_head_intro
    @head = Head.create(category: params[:head][:category], name: params[:head][:name])
    respond_to do |format|
      format.js
    end
  end

  def destroy_head
    # destroy heds here
    Head.find_by_id(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

  def prepare_regulation
    @head = Head.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_regulation
    @regulation = Regulation.create(name: params[:regulation][:name],
                                    definition: params[:regulation][:definition],
                                    head_id: params[:regulation][:head_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_regulation
    Regulation.find_by_id(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_act
    @act = Act.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def act_params
    params.require(:act).permit(:state, :name, :city, :date, :preambula)
  end

  def to_s
    if @document
      @document.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
    else
      super.to_s
    end
  end
end
