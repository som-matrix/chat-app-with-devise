import consumer from "channels/consumer";

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected to chat channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected from chat channel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const chatMessages = document.getElementById("chats");
    const template = document.createElement("template");
    template.innerHTML = data.html;
    const chatElement = template.content.firstChild;
    const chatId = chatElement.id;

    if (data.type === "create") {
      chatMessages.insertAdjacentElement("afterbegin", chatElement);
    } else if (data.type === "update") {
      chatMessages.querySelector(`#${chatId}`).replaceWith(chatElement);
    } else if (data.type === "delete") {
      chatMessages.querySelector(`#${chatId}`).remove();
    }
  },
});
