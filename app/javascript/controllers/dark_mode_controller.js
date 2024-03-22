import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

// Connects to data-controller="dark-mode"
export default class extends Controller {
  toggle(e) {
    this.#toggleTheme(e.target.checked)
  }

  #toggleTheme(isDarkMode) {
    isDarkMode ? Cookies.set("darkMode", "1") : Cookies.remove("darkMode")
    this.element.dataset.bsTheme = isDarkMode ? 'dark' : 'light'
  }
}
