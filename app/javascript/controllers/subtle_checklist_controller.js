import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="subtle-checklist"
export default class extends Controller {
  static values = {
    'multiple': Boolean
  }

  toggle(e) {
    if (this.multipleValue) {
      this.#toggleEl(e.target.closest('.list-group-item:has(> input[type=checkbox])'))
    } else {
      e.target.closest('.list-group')
        .querySelectorAll('.list-group-item:has(> input[type=checkbox])')
        .forEach(this.#uncheckEl)
      this.#checkEl(e.target.closest('.list-group-item:has(> input[type=checkbox])'))
    }
  }

  #toggleEl(el) {
    let checkbox = el.querySelector('input[type=checkbox]')
    el.classList.toggle('list-group-item-secondary')
    checkbox.checked ^= 1
  }

  #checkEl(el) {
    let checkbox = el.querySelector('input[type=checkbox]')
    el.classList.add('list-group-item-secondary')
    checkbox.checked = 1
  }

  #uncheckEl(el) {
    let checkbox = el.querySelector('input[type=checkbox]')
    el.classList.remove('list-group-item-secondary')
    checkbox.checked = 0
  }
}
