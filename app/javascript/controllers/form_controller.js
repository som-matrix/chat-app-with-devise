import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["formContainer"];

  connect() {
    this.formContainerTarget.addEventListener("submit", (e) => {
      document.getElementById("new-chat").src = "/chats";
    });
  }
}
