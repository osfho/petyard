class ModMessagesController < ApplicationController
  before_filter { |b| b.require_power 3 }

  # GET /mod_messages
  # GET /mod_messages.json
  def index
    @mod_messages = ModMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mod_messages }
    end
  end

  # GET /mod_messages/1
  # GET /mod_messages/1.json
  def show
    @mod_message = ModMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mod_message }
    end
  end

  # GET /mod_messages/new
  # GET /mod_messages/new.json
  def new
    @mod_message = ModMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mod_message }
    end
  end

  # GET /mod_messages/1/edit
  def edit
    @mod_message = ModMessage.find(params[:id])
  end

  # POST /mod_messages
  # POST /mod_messages.json
  def create
    @mod_message = ModMessage.new(params[:mod_message])

    respond_to do |format|
      if @mod_message.save
        format.html { redirect_to @mod_message, notice: 'Mod message was successfully created.' }
        format.json { render json: @mod_message, status: :created, location: @mod_message }
      else
        format.html { render action: "new" }
        format.json { render json: @mod_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mod_messages/1
  # PUT /mod_messages/1.json
  def update
    @mod_message = ModMessage.find(params[:id])

    respond_to do |format|
      if @mod_message.update_attributes(params[:mod_message])
        format.html { redirect_to @mod_message, notice: 'Mod message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mod_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod_messages/1
  # DELETE /mod_messages/1.json
  def destroy
    @mod_message = ModMessage.find(params[:id])
    @mod_message.destroy

    respond_to do |format|
      format.html { redirect_to mod_messages_url }
      format.json { head :no_content }
    end
  end
end
