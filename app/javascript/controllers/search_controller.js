import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
    }
    static targets = ["form"]
    search() {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            const searchResults = document.getElementById("search-results")
            this.formTarget.requestSubmit()
            searchResults.style.display = "block"
        }, 500)
    }
}
