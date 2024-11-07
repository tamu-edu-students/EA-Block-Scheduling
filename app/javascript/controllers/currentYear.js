const currentYear = new Date().getFullYear().toString();
const yearElement = document.getElementById("current-year");

if (yearElement) {
    yearElement.textContent = currentYear;
}
