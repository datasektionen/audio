# Song Editor

A lightweight desktop application for managing the song library stored as a JSON file. Built with Python and tkinter — no third-party dependencies required.

---

## Features

- Browse and search songs in a scrollable sidebar
- Edit song fields: **Title**, **Alt. title**, **Meta**, **Text**, and **Notes**
- Add new songs with auto-generated IDs derived from the title
- Delete songs with a confirmation prompt
- Unsaved-change detection — warns before discarding edits when switching songs or closing
- Open, save, and save-as via menu or keyboard shortcuts
- Pass a file path as a command-line argument to open it on launch

---

## Requirements

- Python **3.10** or later
- tkinter (included with CPython on Windows and macOS)

On Linux, tkinter may need to be installed separately:

```bash
# Ubuntu / Debian
sudo apt install python3-tk

# Fedora
sudo dnf install python3-tkinter

# Arch
sudo pacman -S tk
```

No third-party packages are required. There is nothing to `pip install`.

## Running the application

From the root folder run ```song_editor.py```

Mac/Linux
```bash
python3 song_editor.py
```

Windows
```shell
python song_editor.py
```

---

## JSON format

The editor reads and writes JSON files in the following format:

```json
{
  "song_id": {
    "id": "song_id",
    "title": "Song title",
    "alttitle": null,
    "firstline": null,
    "meta": "Melody: ...\nLanguage: ...\n",
    "text": "Verse 1\nVerse 2\n",
    "notes": null
  }
}
```

The top-level keys are song IDs (slugified from the title on creation). The `firstline` field is preserved on save but is not exposed in the editor UI.

---

## Usage

### Opening a file

Go to **File → Open** (or `Ctrl+O`) and select your `songs.json`.

### Editing a song

Click a song in the left sidebar to load it into the editor. Make your changes in the text fields, then click **Save changes** or press `Ctrl+Enter` to apply them to memory.

> Applying changes does **not** write to disk. Use **File → Save** (`Ctrl+S`) to persist the file.

### Adding a song

Click **＋ Add** or press `Ctrl+T`. Enter a title in the dialog and press Enter or click **Add**. The new song is selected and ready to edit immediately.

### Deleting a song

Select a song and click **✕ Delete** (or press `Delete`). You will be asked to confirm before the song is removed.

### Saving

| Action | Menu | Shortcut |
|---|---|---|
| Save to current file | File → Save | `Ctrl+S` |
| Save to a new file | File → Save as… | `Ctrl+Shift+S` |

---

## Keyboard shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl+O` | Open file |
| `Ctrl+S` | Save |
| `Ctrl+Shift+S` | Save as… |
| `Ctrl+N` | New file |
| `Ctrl+T` | Add new song |
| `Ctrl+Enter` | Apply changes to current song |
| `Ctrl+Q` | Quit |

---

## Project structure

```
song-editor/
├── song_editor.py    # Application entry point — the entire app is one file
└── README.md
```