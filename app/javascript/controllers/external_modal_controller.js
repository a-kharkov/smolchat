import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="external-modal"
export default class extends Controller {
  static outlets = [
    'bootstrap-interactions'
  ]

  #externalModal

  connect() {
    this.bootstrapInteractionsOutlet.hideAll()
    this.show()
  }

  show() {
    if (!this.#externalModal)
      this.#externalModal = Modal.getOrCreateInstance(this.element)
    this.#externalModal.show()
  }

  hideBeforeRender() {
    if (this.element.classList.contains('show')) {
      this.#externalModal.hide()
    }
  }
}
