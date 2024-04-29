class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.create!(chat_room_params)
    respond_to do |format|
      if @chat_room
        format.html { redirect_to chat_rooms_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
  def chat_room_params
    params.require(:chat_room).permit(:name, :description)
  end
end
