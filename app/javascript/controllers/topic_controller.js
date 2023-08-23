import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.element.addEventListener("click", () => {
            const categorySelected = document.getElementById("category-selected")
            const categoryField = document.getElementById("question_category_id")
            const searchResults = document.getElementById("search-results")
            categorySelected.innerText = this.element.innerText
            categoryField.value = this.element.id
            searchResults.style.display = "none"

        })
    }
}
