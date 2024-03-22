import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="expandable-textarea"
export default class extends Controller {
  connect() {
    this.element.style.maxHeight = this.#maxHeight()
  }

  resize() {
    this.element.style.height = 0
    this.element.style.height = this.element.scrollHeight + 'px'
  }

  #maxHeight() {
    return this.element.dataset['autoresizeMaxHeight'] || '300px'
  }
}
