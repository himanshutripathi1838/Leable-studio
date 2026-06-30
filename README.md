---
title: Railway Pole Labeling
emoji: 🚂
colorFrom: blue
colorTo: indigo
sdk: docker
app_port: 7860
pinned: false
---

# Railway Pole Labeling - Label Studio Setup


This folder contains a local Label Studio setup for railway pole labeling.

## Installed Setup

- Python: `3.13.1`
- Virtual environment: `venv`
- Label Studio: `1.23.0`
- Label Studio data directory: `.label-studio`
- Local URL: `http://localhost:8080`
- If port `8080` is already busy, Label Studio may start at `http://localhost:8081`

## Start Label Studio

Open PowerShell and run:

```powershell
cd D:\Railway_Pole_Labeling
.\start_label_studio.ps1
```

Then open:

```text
http://localhost:8080
```

If the terminal says `Port 8080 is in use` and starts at `8081`, open:

```text
http://localhost:8081
```

## Why BASE_DATA_DIR Is Set

Label Studio tried to use:

```text
C:\Users\HP\AppData\Local\label-studio
```

That path gave a Windows permission error. To keep everything safe inside this project folder, Label Studio is started with:

```powershell
$env:BASE_DATA_DIR = "D:\Railway_Pole_Labeling\.label-studio"
```

This stores the database, media, exports, and other Label Studio files inside:

```text
D:\Railway_Pole_Labeling\.label-studio
```

## Import Images from a Folder

Put images inside:

```text
D:\Railway_Pole_Labeling\images
```

The start script enables local file serving:

```powershell
$env:LABEL_STUDIO_LOCAL_FILES_SERVING_ENABLED = "true"
$env:LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT = "D:\Railway_Pole_Labeling"
```

In Label Studio:

1. Open your project.
2. Go to `Settings`.
3. Open `Storage` or `Cloud Storage`.
4. Add `Source Storage`.
5. Select `Local files`.
6. Use this folder path:

```text
D:\Railway_Pole_Labeling\images
```

Then sync/import the storage.

## Import More Than 100 Images

If browser upload only imports 100 images, use the generated JSON import method.

First, put all images here:

```text
D:\Railway_Pole_Labeling\images
```

Then run:

```powershell
cd D:\Railway_Pole_Labeling
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\generate_label_studio_tasks.ps1
```

This creates:

```text
D:\Railway_Pole_Labeling\label_studio_tasks.json
```

In Label Studio, import this JSON file instead of selecting images directly.

For the labeling interface, make sure the image tag uses:

```xml
<Image name="image" value="$image"/>
```

## Verify Installation

Run:

```powershell
cd D:\Railway_Pole_Labeling
.\venv\Scripts\python.exe -m pip show label-studio
```

Expected version:

```text
Version: 1.23.0
```

## Notes

- Do not delete the `venv` folder unless you want to reinstall Label Studio.
- Do not delete `.label-studio` unless you intentionally want to remove local Label Studio data.
- Existing project files should not be deleted during setup or startup.
