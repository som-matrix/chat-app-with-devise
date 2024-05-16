class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    @chats = Chat.all.order(id: :desc)
  end

  # GET /chats/1 or /chats/1.json
  def show
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)

    respond_to do |format|
      if @chat.save
        format.turbo_stream { render turbo_stream:
            turbo_stream.prepend("chats", partial: "chat", locals: { chat: @chat }) }
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully created." }
        ActionCable.server.broadcast("chat_channel",
            { html: render_to_string(partial: "chat", locals: { chat: @chat }), type: "create" })
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chats_path, notice: "Chat was successfully updated." }
        ActionCable.server.broadcast("chat_channel",
            { html: render_to_string(partial: "chat", locals: { chat: @chat }), type: "update" })
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@chat) }
      ActionCable.server.broadcast("chat_channel",
          { html: render_to_string(partial: "chat", locals: { chat: @chat }), type: "delete" })
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:message)
  end
end
