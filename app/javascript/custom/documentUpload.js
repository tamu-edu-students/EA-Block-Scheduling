const dropArea = document.getElementById('drop-area')
const fileInput = document.getElementById('file-input')
const progressBar = document.getElementById('progress-bar')
const statusMessage = document.getElementById('status')

;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, preventDefaults, false)
});

function preventDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
}

;['dragenter', 'dragover'].forEach(eventName => {
    dropArea.addEventListener(eventName, () => {
        dropArea.classList.add('highlight');
    }, false)
});

;['dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, () => {
        dropArea.classList.remove('highlight');
    }, false)
});

dropArea.addEventListener('drop', handleDrop, false);

function handleDrop(e) {
    const files = e.dataTransfer.files;
    handleFiles(files);
}

function handleFiles(files) {
    const file = files[0];
    uploadFile(file);
}

function uploadFile(file) {
    const url = '/documents';
    const formData = new FormData();
    formData.append('document[file]', file);

    fetch(url, {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                statusMessage.innerHTML = 'File uploaded successfully';
            } else {
                statusMessage.innerHTML = 'File upload failed: ' + data.error;
            }
        })
        .catch(error => {
            statusMessage.innerHTML = 'File upload failed: ' + error.message;
        });
}