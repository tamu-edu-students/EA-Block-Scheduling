// schedule_viewer.js
document.addEventListener("DOMContentLoaded", function() {
  const modal = document.getElementById("classModal");
  const classTitle = document.getElementById("classTitle");
  const classDetails = document.getElementById("classDetails");
  const closeBtn = document.querySelector(".close");

  document.querySelectorAll(".class-block").forEach(block => {
    block.addEventListener("click", function() {
      classTitle.textContent = block.getAttribute("data-name");
      classDetails.textContent = block.getAttribute("data-details").replace(/\\n/g, "<br>");
      modal.style.display = "block";
    });
  });

  closeBtn.onclick = function() {
    modal.style.display = "none";
  };

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  };
});

function closeModal() {
  document.getElementById("classModal").style.display = "none";
}
