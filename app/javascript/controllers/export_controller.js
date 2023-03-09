import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ "query", "button" ]

  connect() {
    this.queryTarget.focus()
    
  }
  check() {
    if (this.queryTarget.value.length > 0) {
      this.buttonTarget.disabled = false
    } else {
      this.buttonTarget.disabled = true
    }
  }
}