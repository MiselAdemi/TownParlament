class ActsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_act, only: [:show, :edit, :update, :destroy]

  # GET /acts
  # GET /acts.json
  def index
    if current_user.citizen?
      @acts = Act.where(:status => "approved")
    else
      @acts = Act.all
    end
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
    @akt = Act.find(params[:id])
    @aktlink = "http://localhost:8020#{Connection::MarkLogic.new.acts_uri(@akt)}"
    @client = Connection::MarkLogic.client

    mark_logic = Connection::MarkLogic.new
    act_from_ml = mark_logic.download_act(@akt)

    @act = Nokogiri::XML(act_from_ml)
  rescue
    @act = Transform::ToXml.transform(@akt)
  end

  # GET /acts/new
  def new
    @act = Act.new
    @meeting = Meeting.find(1)
    init_heads
    redirect_to root_path, notice: 'You cannot add new act when Session is in progress!' and return if @meeting.status
  end

  # GET /acts/1/edit
  def edit
    @amandment = Amandment.new
    @meeting = Meeting.find(1)
    init_heads
    redirect_to acts_path, notice: 'You cannot edit act when Session is in progress!' and return if @meeting.status
  end

  # POST /acts
  # POST /acts.json
  def create
    @act = Act.new(act_params)

    if @act.save
      session[:heads].each do |head_id|
        Head.find_by_id(head_id).update(act_id: @act.id)
      end

      act_xml = Transform::ToXml.transform(@act).to_s

      mark_logic = Connection::MarkLogic.new
      mark_logic.upload_act(@act, act_xml)

      redirect_to @act, notice: 'Act was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    @act_new = @act.dup
    @act_new.heads = @act.heads
    @act_new.update(act_params)

    session[:heads].each do |head_id|
      head = Head.find(head_id)
      head.update(act_id: @act.id)
      @act_new.heads << head
    end

    act_xml = Transform::ToXml.transform(@act_new).to_s

    mark_logic = Connection::MarkLogic.new
    mark_logic.upload_amandment(@act_new, act_xml)

    respond_to do |format|
      format.js
    end
  end

  # DELETE /acts/1
  # DELETE /acts/1.json
  def destroy
    @akt = Act.find(params[:id])
    client = Connection::MarkLogic.new.client

    @act.amandments.each do |amandment|
      client.send_corona_request("/v1/documents?uri=/amandments/amandment_#{amandment.owner_id}.xml", :delete)
      Act.find(amandment.owner_id).destroy
    end

    client.send_corona_request("/v1/documents?uri=/acts/act_#{@akt.id}.xml", :delete)
    @act.destroy
    redirect_to acts_url, notice: 'Act was successfully destroyed.'
  end

  def create_head_intro
    if params[:head][:act_id]
      @head = Head.create(category: params[:head][:category], name: params[:head][:name], act_id: params[:head][:act_id])

    else
      @head = Head.create(category: params[:head][:category], name: params[:head][:name])
    end

    add_head_id(@head.id)
    respond_to do |format|
      format.js
    end
  end

  def destroy_head
    # destroy heds here
    @head = Head.find_by_id(params[:id]).destroy
    remove_head_id(@head.id)
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

  def prepare_subject
    @regulation = Regulation.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_subject
    @subject = Subject.create(name: params[:subject][:name], regulation_id: params[:subject][:regulation_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_subject
    Subject.find_by_id(params[:id]).destroy

    respond_to do |format|
      format.js
    end
  end

  def prepare_clause
    @subject = Subject.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_clause
    @clause = Clause.create(name: params[:clause][:name],
                            subject_id: params[:clause][:subject_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy_clause
    Clause.find_by_id(params[:id]).destroy

    respond_to do |format|
      format.js
    end
  end

  def prepare_stance
    @clause = Clause.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_stance
    @stance = Stance.create(name: params[:stance][:name],
                            content: params[:stance][:content],
                            clause_id: params[:stance][:clause_id])

    respond_to do |format|
      format.js
    end
  end

  def destroy_stance
    Stance.find_by_id(params[:id]).destroy

    respond_to do |format|
      format.js
    end
  end

  def prepare_dot
    @stance = Stance.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_dot
    @dot = Dot.create(name: params[:dot][:name],
                      content: params[:dot][:content],
                      stance_id: params[:dot][:stance_id])

    respond_to do |format|
      format.js
    end
  end

  def destroy_dot
    Dot.find_by_id(params[:id]).destroy

    respond_to do |format|
      format.js
    end
  end

  def prepare_subdot
    @dot = Dot.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_subdot
    @subdot = Subdot.create(name: params[:subdot][:name],
                            content: params[:subdot][:content],
                            dot_id: params[:subdot][:dot_id])

    respond_to do |format|
      format.js
    end
  end

  def destroy_subdot
    Subdot.find_by_id(params[:id]).destroy

    respond_to do |format|
      format.js
    end
  end

  def prepare_paragraph
    @subdot = Subdot.find_by_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create_paragraph
    @paragraph = Paragraph.create(name: params[:paragraph][:name],
                                  content: params[:paragraph][:content],
                                  subdot_id: params[:paragraph][:subdot_id])

    respond_to do |format|
      format.js
    end
  end

  def destroy_paragraph
    Paragraph.find_by_id(params[:id]).destroy

    respond_to do |format|
      format.js
    end
  end

  def html
    @act = Act.find_by_id(params[:act_id])
  end

  def pdf
    @act = Act.find_by_id(params[:act_id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@act.name}-#{@act.date}",
        template: '/acts/pdf'
      end

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

  def init_heads
    session[:heads] = []
  end

  def add_head_id(id)
    session[:heads] << id
  end

  def remove_head_id(id)
    session[:heads].delete(id)
  end
end
