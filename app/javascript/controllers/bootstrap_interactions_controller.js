import { Controller } from "@hotwired/stimulus"
import { Modal, Offcanvas } from "bootstrap"

// Connects to data-controller="bootstrap-interactions"
export default class extends Controller {
  #modals
  #offcanvases

  connect() {
    this.#modals = [...this.element.querySelectorAll('.modal')].map(el => {
      return Modal.getOrCreateInstance(el)
    })
    this.#offcanvases = [...this.element.querySelectorAll('.offcanvas')].map(el => {
      return Offcanvas.getOrCreateInstance(el)
    })
  }

  hideAll() {
    this.#modals.forEach(m => m.hide())
    this.#offcanvases.forEach(m => m.hide())
  }
}
