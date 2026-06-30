Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

$env:BASE_DATA_DIR = "D:\Railway_Pole_Labeling\.label-studio"
$env:LABEL_STUDIO_LOCAL_FILES_SERVING_ENABLED = "true"
$env:LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT = "D:\Railway_Pole_Labeling"

.\venv\Scripts\Activate.ps1
label-studio
