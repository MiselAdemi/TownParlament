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
    @client = Connection::MarkLogic.client
    @akt_xml = Transform::ToXml.transform(@akt)

    @client.send_corona_request("/v1/documents?database=Tim23&uri=/test/#{@akt.name}.xml", :put, @akt_xml.to_s)

    #@act = @client.send_corona_request("/v1/documents?database=Tim23&uri=/test/#{@akt.name}.xml")
    #@act  = Nokogiri::XML(@act)
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

    respond_to do |format|
      if @act.save
        format.html { redirect_to @act, notice: 'Act was successfully created.' }
        format.json { render :show, status: :created, location: @act }
      else
        format.html { render :new }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    respond_to do |format|
      if @act.update(act_params)
        format.html { redirect_to @act, notice: 'Act was successfully updated.' }
        format.json { render :show, status: :ok, location: @act }
      else
        format.html { render :edit }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_act
    @act = Act.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def act_params
    params.fetch(:act, {})
  end

  def to_s
    if @document
      @document.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
    else
      super.to_s
    end
  end
end
