const dropArea = document.getElementById('drop-area');
const fileInput = document.getElementById('file-input');
const progressBar = document.getElementById('progress-bar');
const statusMessage = document.getElementById('status');

// Prevent default drag behaviors
;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, preventDefaults, false)
});

function preventDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
}

// Highlight drop area when item is dragged over
;['dragenter', 'dragover'].forEach(eventName => {
    dropArea.classList.add('highlight');
});

;['dragleave', 'drop'].forEach(eventName => {
    dropArea.classList.remove('highlight');
});

// Handle dropped files
dropArea.addEventListener('drop', handleDrop, false);
dropArea.addEventListener('click', () => fileInput.click()); // Click to trigger file input

function handleDrop(e) {
    const files = e.dataTransfer.files;
    handleFiles(files);
}

function handleFiles(files) {
    const file = files[0];
    fileInput.files = files;  // Set the file input's files for form submission
}

document.getElementById('document-upload-form').addEventListener('submit', (e) => {
    progressBar.style.display = 'block';
    const formData = new FormData(e.target);
    fetch(e.target.action, {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                statusMessage.innerHTML = 'File uploaded successfully!';
            } else {
                statusMessage.innerHTML = 'File upload failed: ' + data.error;
            }
        })
        .catch(error => {
            statusMessage.innerHTML = 'File upload failed: ' + error.message;
        });

    e.preventDefault();  // Prevent the default form submission
});