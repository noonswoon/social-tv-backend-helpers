class ChatroomManagersController < ApplicationController
  # GET /chatroom_managers
  # GET /chatroom_managers.json
  def index
    @chatroom_managers = ChatroomManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chatroom_managers }
    end
  end

  # GET /chatroom_managers/1
  # GET /chatroom_managers/1.json
  def show
    @chatroom_manager = ChatroomManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chatroom_manager }
    end
  end

  # GET /chatroom_managers/new
  # GET /chatroom_managers/new.json
  def new
    @chatroom_manager = ChatroomManager.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chatroom_manager }
    end
  end

  # GET /chatroom_managers/1/edit
  def edit
    @chatroom_manager = ChatroomManager.find(params[:id])
  end

  # POST /chatroom_managers
  # POST /chatroom_managers.json
  def create
    @chatroom_manager = ChatroomManager.new(params[:chatroom_manager])

    respond_to do |format|
      if @chatroom_manager.save
        format.html { redirect_to @chatroom_manager, notice: 'Chatroom manager was successfully created.' }
        format.json { render json: @chatroom_manager, status: :created, location: @chatroom_manager }
      else
        format.html { render action: "new" }
        format.json { render json: @chatroom_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chatroom_managers/1
  # PUT /chatroom_managers/1.json
  def update
    @chatroom_manager = ChatroomManager.find(params[:id])

    respond_to do |format|
      if @chatroom_manager.update_attributes(params[:chatroom_manager])
        format.html { redirect_to @chatroom_manager, notice: 'Chatroom manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chatroom_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatroom_managers/1
  # DELETE /chatroom_managers/1.json
  def destroy
    @chatroom_manager = ChatroomManager.find(params[:id])
    @chatroom_manager.destroy

    respond_to do |format|
      format.html { redirect_to chatroom_managers_url }
      format.json { head :no_content }
    end
  end

  def get_chatroom_number_users
    chatroom_data = ChatroomManager.find_by_chatroom_id(params[:id])
    if(chatroom_data != nil)
      @chatroom_number_users = {'chatroom_number_users' => chatroom_data.number_users }
    else 
      ##auto-create that room if it doesn't exist
      ChatroomManager.create(:chatroom_id => params[:id], :number_users => 0)
      @chatroom_number_users = {'chatroom_number_users' => 0 }
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chatroom_number_users }
    end
  end

  def increment_number_users
    @chatroom_data = ChatroomManager.find_by_chatroom_id(params[:id])
    updated_number_users = @chatroom_data.number_users + 1
    respond_to do |format|
      if @chatroom_data.update_attributes(:number_users => updated_number_users)
        format.html { redirect_to @chatroom_data, notice: 'Chatroom number was successfully incremented.' }
        format.json {render json: @chatroom_data }
      end
    end
  end

  def decrement_number_users
    @chatroom_data = ChatroomManager.find_by_chatroom_id(params[:id])
    updated_number_users = @chatroom_data.number_users - 1
    if(updated_number_users < 0)
      updated_number_users = 0
    end

    respond_to do |format|
      if @chatroom_data.update_attributes(:number_users => updated_number_users)
        format.html { redirect_to @chatroom_data, notice: 'Chatroom number was successfully decremented.' }
        format.json {render json: @chatroom_data }
      end
    end
  end

end
