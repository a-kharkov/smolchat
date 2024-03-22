import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = [
    'newMessageForm',
    'message'
  ]

  #scrollBehavior = 'instant'

  connect() {
    this.#scrollBehavior = 'smooth'
  }

  messageTargetConnected(el) {
    this.#addHeaderAndPadding(el)
    el.scrollIntoView({ behavior: this.#scrollBehavior })
  }

  newlineOrSubmit(e) {
    if (e.keyCode === 13) {
      e.preventDefault()
      if (e.shiftKey) {
        e.target.value += '\n'
        e.target.dispatchEvent(new Event('input'))
      } else
        this.newMessageFormTarget.requestSubmit()
    }
  }

  #addHeaderAndPadding(el) {
    let prevEl = el.closest('#messages_container').querySelector(`.message-card:has(+ #${el.id})`)
    if (prevEl?.dataset?.userId !== el.dataset.userId) {
      el.classList.add('mt-2')
      if (el.classList.contains('me-auto'))
        el.querySelector('header').classList.remove('d-none')
    }
  }
}
