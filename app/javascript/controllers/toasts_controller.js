import { Controller } from "@hotwired/stimulus"
import { Toast } from "bootstrap"

// Connects to data-controller="toasts"
export default class extends Controller {
  #toast

  connect() {
    this.#toast = Toast.getOrCreateInstance(this.element, { delay: 10000 })
    this.#toast.show()
  }

  remove() { this.element.remove() }
}
