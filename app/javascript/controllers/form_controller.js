import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["formt","select","button"]
  connect() {
    console.log("Form controller connected")
  }

  update(event) {
    console.log(this.selectTarget.value)
    this.buttonTarget.click();
  }
}
