class PushNotificationDetailsController < ApplicationController
  skip_before_filter  :verify_authenticity_token 
  http_basic_authenticate_with :name => "chatterbox", :password => "d1srupt"

  # GET /push_notification_details
  # GET /push_notification_details.json
  def index
    @push_notification_details = PushNotificationDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @push_notification_details }
    end
  end

  # GET /push_notification_details/1
  # GET /push_notification_details/1.json
  def show
    @push_notification_detail = PushNotificationDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @push_notification_detail }
    end
  end

  # GET /push_notification_details/new
  # GET /push_notification_details/new.json
  def new
    @push_notification_detail = PushNotificationDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @push_notification_detail }
    end
  end

  # GET /push_notification_details/1/edit
  def edit
    @push_notification_detail = PushNotificationDetail.find(params[:id])
  end

  # POST /push_notification_details
  # POST /push_notification_details.json
  def create
    @push_notification_detail = PushNotificationDetail.new(params[:push_notification_detail])

    respond_to do |format|
      if @push_notification_detail.save
        format.html { redirect_to @push_notification_detail, notice: 'Push notification detail was successfully created.' }
        format.json { render json: @push_notification_detail, status: :created, location: @push_notification_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @push_notification_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /push_notification_details/1
  # PUT /push_notification_details/1.json
  def update
    @push_notification_detail = PushNotificationDetail.find(params[:id])

    respond_to do |format|
      if @push_notification_detail.update_attributes(params[:push_notification_detail])
        format.html { redirect_to @push_notification_detail, notice: 'Push notification detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @push_notification_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # NO DESTROY FUNCTION
  # DELETE /push_notification_details/1
  # DELETE /push_notification_details/1.json
  #def destroy
  #  @push_notification_detail = PushNotificationDetail.find(params[:id])
  #  @push_notification_detail.destroy

  #  respond_to do |format|
  #    format.html { redirect_to push_notification_details_url }
  #    format.json { head :no_content }
  #  end
  #end

  ## ADD-ON
  def show_by_userid
    @push_notification_detail = PushNotificationDetail.find_by_userid(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @push_notification_detail }
    end
  end

  def get_pn_permissions
    user_pn_data = PushNotificationDetail.find_by_userid(params[:id])
    if(user_pn_data != nil)
      @user_pn_permissions = {'user_pn_permissions'=>[user_pn_data.notify_when_comment, user_pn_data.notify_when_friend_checkin]}
    else 
      @user_pn_permissions = {'user_pn_permissions'=>[1,1]}
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_pn_permissions }
    end
  end

  def is_allow_to_send_when_get_comment
    user_pn_data = PushNotificationDetail.find_by_userid(params[:id])
    if(user_pn_data != nil)
      @push_notification_detail = user_pn_data.notify_when_comment
    else 
      @push_notification_detail = -1
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @push_notification_detail }
    end
  end

  def is_allow_to_send_when_friend_checkin
    user_pn_data = PushNotificationDetail.find_by_userid(params[:id])
    if(user_pn_data != nil)
      @push_notification_detail = user_pn_data.notify_when_friend_checkin
    else 
      @push_notification_detail = -1
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @push_notification_detail }
    end
  end

  def update_notify_permission
    @push_notification_detail = PushNotificationDetail.find_by_userid(params[:id])

    respond_to do |format|
      if @push_notification_detail.update_attributes(params[:push_notification_detail])
        format.html { redirect_to @push_notification_detail, notice: 'Push notification detail was successfully updated.' }
        format.json {render json: @push_notification_detail }
      end
    end
  end

  def send_notification
    @return_message = 'nothing'
    user_pn_data = PushNotificationDetail.find_by_userid(params[:userid])
    message_to_send = params[:message_to_send]
    pn_sending_type = params[:pn_sending_type]
    if(true) #if(pn_sending_type == 1 && user_pn_data.notify_when_comment == 1) #send the notification
      @return_message = 'send notification when user gets comments'
      notification = {
        #:schedule_for => 1.hour.from_now,
        :device_tokens => [user_pn_data.pn_device_token],
        :aps => {:alert => message_to_send, :badge => '+1'}
      }
      Urbanairship.push notification # => true
    elsif (pn_sending_type == 2 && user_pn_data.notify_when_friend_checkin == 1)
      @return_message = 'send notification when user gets comments'
      notification = {
        #:schedule_for => 1.hour.from_now,
        :device_tokens => [user_pn_data.pn_device_token],
        :aps => {:alert => message_to_send, :badge => '+1'}
      }
      Urbanairship.push notification # => true
    else
      @return_message = 'do not have permission to send pn type '+pn_sending_type.to_s
    end
    respond_to do |format|
      format.json {render json: @return_message }
    end
  end
end