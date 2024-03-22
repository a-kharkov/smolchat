import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

// Connects to data-controller="tz"
export default class extends Controller {
  connect() {
    Cookies.set("timezone", Intl.DateTimeFormat().resolvedOptions().timeZone, { expires: 1 })
  }
}
