import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ "queryFlow", "buttonFlow" ]

  connect() {
    this.queryFlowTarget.focus()
  }

  check() {
    if (this.queryFlowTarget.value.length > 0) {
      this.buttonFlowTarget.disabled = false
    } else {
      this.buttonFlowTarget.disabled = true
    }
  }
}