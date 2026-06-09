#!/usr/bin/env python3
"""
Song Editor - A tkinter UI for editing songs.json
"""

import json
import os
import re
import tkinter as tk
from tkinter import ttk, messagebox, filedialog


# Fields that must be XML-safe (all except title and text)
_XML_ESCAPED_FIELDS = {"alttitle", "meta", "notes"}

# All standard named XML/HTML character references that are not valid bare XML
# Maps the literal character → its XML entity reference
_XML_ESCAPE_TABLE: dict[str, str] = {
    # The five characters that are invalid in XML content / attributes
    "&":  "&amp;",    # must be first so we don't double-escape others
    "<":  "&lt;",
    ">":  "&gt;",
    '"':  "&quot;",
    "'":  "&apos;",
    # Soft hyphen (U+00AD) — often written &shy; in HTML but invalid bare in XML
    "\u00ad": "&shy;",
    # Non-breaking space
    "\u00a0": "&nbsp;",
    # Common typographic characters
    "\u2013": "&ndash;",
    "\u2014": "&mdash;",
    "\u2018": "&lsquo;",
    "\u2019": "&rsquo;",
    "\u201c": "&ldquo;",
    "\u201d": "&rdquo;",
    "\u2026": "&hellip;",
    "\u00a9": "&copy;",
    "\u00ae": "&reg;",
    "\u2122": "&trade;",
}

# Reverse map for unescaping when loading into the editor
_XML_UNESCAPE_TABLE: dict[str, str] = {v: k for k, v in _XML_ESCAPE_TABLE.items()}


def xml_escape(text: str) -> str:
    """Escape characters that are invalid or problematic in XML."""
    for char, entity in _XML_ESCAPE_TABLE.items():
        text = text.replace(char, entity)
    return text


def xml_unescape(text: str) -> str:
    """Unescape XML entities back to their literal characters for display."""
    for entity, char in _XML_UNESCAPE_TABLE.items():
        text = text.replace(entity, char)
    return text


# Transliteration map for accented/special characters → ASCII equivalents
_TRANSLITERATE: dict[str, str] = {
    # Scandinavian
    "å": "a", "ä": "a", "æ": "ae", "ø": "o", "ö": "o",
    "Å": "a", "Ä": "a", "Æ": "ae", "Ø": "o", "Ö": "o",
    # German
    "ü": "u", "Ü": "u", "ß": "ss",
    # French / Spanish / Portuguese
    "à": "a", "á": "a", "â": "a", "ã": "a",
    "è": "e", "é": "e", "ê": "e", "ë": "e",
    "ì": "i", "í": "i", "î": "i", "ï": "i",
    "ò": "o", "ó": "o", "ô": "o", "õ": "o",
    "ù": "u", "ú": "u", "û": "u",
    "ý": "y", "ÿ": "y",
    "ñ": "n", "ç": "c",
    "À": "a", "Á": "a", "Â": "a", "Ã": "a",
    "È": "e", "É": "e", "Ê": "e", "Ë": "e",
    "Ì": "i", "Í": "i", "Î": "i", "Ï": "i",
    "Ò": "o", "Ó": "o", "Ô": "o", "Õ": "o",
    "Ù": "u", "Ú": "u", "Û": "u",
    "Ý": "y", "Ñ": "n", "Ç": "c",
    # Czech / Slovak / Croatian / Slovenian
    "č": "c", "ď": "d", "ě": "e", "ň": "n", "ř": "r",
    "š": "s", "ť": "t", "ž": "z",
    "Č": "c", "Ď": "d", "Ě": "e", "Ň": "n", "Ř": "r",
    "Š": "s", "Ť": "t", "Ž": "z",
    # Polish
    "ą": "a", "ć": "c", "ę": "e", "ł": "l", "ń": "n",
    "ś": "s", "ź": "z", "ż": "z",
    "Ą": "a", "Ć": "c", "Ę": "e", "Ł": "l", "Ń": "n",
    "Ś": "s", "Ź": "z", "Ż": "z",
    # Misc
    "ð": "d", "þ": "th", "Ð": "d", "Þ": "th",
    "ĸ": "k", "ŋ": "ng",
}


def _transliterate(text: str) -> str:
    """Replace accented/special characters with ASCII equivalents."""
    return "".join(_TRANSLITERATE.get(ch, ch) for ch in text)


def make_id(title: str, existing_ids: set) -> str:
    """Generate a slug-style ID from the title, avoiding collisions."""
    slug = _transliterate(title.lower())
    base = re.sub(r"[^a-z0-9]+", "_", slug).strip("_") or "song"
    candidate = base
    counter = 2
    while candidate in existing_ids:
        candidate = f"{base}_{counter}"
        counter += 1
    return candidate


class SongEditor(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Song Editor")
        self.geometry("1000x700")
        self.minsize(800, 550)

        self.filepath: str | None = None
        self.songs: dict = {}
        self.current_id: str | None = None
        self.dirty = False          # unsaved file changes
        self.field_dirty = False    # unsaved field changes
        self._loading = False       # suppress change events during load

        self._build_ui()
        self._bind_shortcuts()
        self._set_empty_state()

    # ------------------------------------------------------------------ #
    # UI construction
    # ------------------------------------------------------------------ #

    def _build_ui(self):
        # ── Menu bar ──────────────────────────────────────────────────── #
        menubar = tk.Menu(self)
        self.config(menu=menubar)

        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="New file",        command=self.new_file,   accelerator="Ctrl+N")
        file_menu.add_command(label="Open…",           command=self.open_file,  accelerator="Ctrl+O")
        file_menu.add_command(label="Save",            command=self.save_file,  accelerator="Ctrl+S")
        file_menu.add_command(label="Save as…",        command=self.save_as,    accelerator="Ctrl+Shift+S")
        file_menu.add_separator()
        file_menu.add_command(label="Quit",            command=self.quit_app,   accelerator="Ctrl+Q")

        song_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Song", menu=song_menu)
        song_menu.add_command(label="Add new song",    command=self.add_song,   accelerator="Ctrl+T")
        song_menu.add_command(label="Delete song",     command=self.delete_song,accelerator="Delete")
        song_menu.add_separator()
        song_menu.add_command(label="Save changes",    command=self.apply_changes, accelerator="Ctrl+Return")

        # ── Status bar ────────────────────────────────────────────────── #
        self.status_var = tk.StringVar(value="No file open")
        status_bar = tk.Label(self, textvariable=self.status_var, anchor="w",
                              relief="sunken", padx=6)
        status_bar.pack(side="bottom", fill="x")

        # ── Main paned window ─────────────────────────────────────────── #
        pane = tk.PanedWindow(self, orient="horizontal", sashwidth=5,
                              sashrelief="flat", bg="#cccccc")
        pane.pack(fill="both", expand=True, padx=4, pady=4)

        # Left: song list
        left_frame = tk.Frame(pane, width=220)
        pane.add(left_frame, minsize=160)

        tk.Label(left_frame, text="Songs", font=("TkDefaultFont", 10, "bold")).pack(
            anchor="w", padx=6, pady=(6, 2))

        # Search
        search_frame = tk.Frame(left_frame)
        search_frame.pack(fill="x", padx=4, pady=(0, 4))
        tk.Label(search_frame, text="🔍").pack(side="left")
        self.search_var = tk.StringVar()
        self.search_var.trace_add("write", lambda *_: self._filter_list())
        tk.Entry(search_frame, textvariable=self.search_var).pack(side="left", fill="x", expand=True)

        list_frame = tk.Frame(left_frame)
        list_frame.pack(fill="both", expand=True, padx=4)

        scrollbar = tk.Scrollbar(list_frame)
        scrollbar.pack(side="right", fill="y")

        self.listbox = tk.Listbox(list_frame, yscrollcommand=scrollbar.set,
                                  activestyle="dotbox", selectmode="single",
                                  font=("TkDefaultFont", 10))
        self.listbox.pack(side="left", fill="both", expand=True)
        scrollbar.config(command=self.listbox.yview)
        self.listbox.bind("<<ListboxSelect>>", self._on_select)

        btn_frame = tk.Frame(left_frame)
        btn_frame.pack(fill="x", padx=4, pady=4)
        tk.Button(btn_frame, text="＋ Add", command=self.add_song).pack(side="left", expand=True, fill="x")
        tk.Button(btn_frame, text="✕ Delete", command=self.delete_song).pack(side="left", expand=True, fill="x")

        # Right: editor
        right_frame = tk.Frame(pane)
        pane.add(right_frame, minsize=400)

        self.editor_frame = tk.Frame(right_frame)
        self.editor_frame.pack(fill="both", expand=True, padx=8, pady=8)

        self.fields: dict[str, tk.Widget] = {}
        field_defs = [
            ("title",    "Title",             False),
            ("alttitle", "Alt. title",        False),
            ("meta",     "Meta",              True),
            ("text",     "Text",              True),
            ("notes",    "Notes",             True),
        ]

        for row_idx, (key, label, multiline) in enumerate(field_defs):
            tk.Label(self.editor_frame, text=label + ":", anchor="nw",
                     font=("TkDefaultFont", 9, "bold")).grid(
                row=row_idx * 2, column=0, sticky="nw", pady=(6, 0))

            if multiline:
                widget = tk.Text(self.editor_frame, wrap="word", relief="solid",
                                 font=("TkFixedFont", 10),
                                 height=5 if key in ("text", "meta") else 3)
                widget.bind("<<Modified>>", lambda e, k=key: self._on_field_change(k))
            else:
                var = tk.StringVar()
                widget = tk.Entry(self.editor_frame, textvariable=var,
                                  font=("TkDefaultFont", 10), relief="solid")
                var.trace_add("write", lambda *_, k=key: self._on_field_change(k))
                widget._var = var  # type: ignore[attr-defined]

            widget.grid(row=row_idx * 2 + 1, column=0, sticky="ew", pady=(2, 0))
            self.fields[key] = widget

        self.editor_frame.columnconfigure(0, weight=1)

        # Row weights so Text widgets expand
        for r in [3, 5, 7, 9]:
            self.editor_frame.rowconfigure(r, weight=1)

        # Save-changes button
        self.apply_btn = tk.Button(right_frame, text="Save changes  (Ctrl+Enter)",
                                   command=self.apply_changes, state="disabled",
                                   bg="#4a90d9", fg="white", relief="flat",
                                   font=("TkDefaultFont", 10, "bold"), pady=4)
        self.apply_btn.pack(fill="x", padx=8, pady=(0, 8))

    # ------------------------------------------------------------------ #
    # Keybindings
    # ------------------------------------------------------------------ #

    def _bind_shortcuts(self):
        self.bind("<Control-n>", lambda e: self.new_file())
        self.bind("<Control-o>", lambda e: self.open_file())
        self.bind("<Control-s>", lambda e: self.save_file())
        self.bind("<Control-S>", lambda e: self.save_as())
        self.bind("<Control-q>", lambda e: self.quit_app())
        self.bind("<Control-t>", lambda e: self.add_song())
        self.bind("<Control-Return>", lambda e: self.apply_changes())

    # ------------------------------------------------------------------ #
    # File operations
    # ------------------------------------------------------------------ #

    def new_file(self):
        if not self._confirm_discard():
            return
        self.filepath = None
        self.songs = {}
        self.dirty = False
        self._refresh_list()
        self._set_empty_state()
        self.status_var.set("New file (unsaved)")

    def open_file(self):
        if not self._confirm_discard():
            return
        path = filedialog.askopenfilename(
            title="Open songs.json",
            filetypes=[("JSON files", "*.json"), ("All files", "*.*")])
        if not path:
            return
        try:
            with open(path, encoding="utf-8") as f:
                self.songs = json.load(f)
            self.filepath = path
            self.dirty = False
            self._refresh_list()
            self._set_empty_state()
            self.status_var.set(f"Opened: {path}  ({len(self.songs)} songs)")
        except Exception as exc:
            messagebox.showerror("Error opening file", str(exc))

    def save_file(self):
        if not self.filepath:
            self.save_as()
            return
        self._write(self.filepath)

    def save_as(self):
        path = filedialog.asksaveasfilename(
            title="Save as…",
            defaultextension=".json",
            filetypes=[("JSON files", "*.json"), ("All files", "*.*")])
        if path:
            self._write(path)
            self.filepath = path

    def _write(self, path: str):
        try:
            with open(path, "w", encoding="utf-8") as f:
                json.dump(self.songs, f, ensure_ascii=False, indent=1)
            self.dirty = False
            self.status_var.set(f"Saved: {path}  ({len(self.songs)} songs)")
        except Exception as exc:
            messagebox.showerror("Error saving file", str(exc))

    def quit_app(self):
        if self._confirm_discard():
            self.destroy()

    def _confirm_discard(self) -> bool:
        """Return True if it's safe to discard current state."""
        if self.dirty or self.field_dirty:
            ans = messagebox.askyesnocancel(
                "Unsaved changes", "You have unsaved changes. Discard them?")
            if ans is None:
                return False   # cancel
            return ans         # yes=True / no=False
        return True

    # ------------------------------------------------------------------ #
    # Song list management
    # ------------------------------------------------------------------ #

    def _refresh_list(self, keep_selection: str | None = None):
        self.listbox.delete(0, "end")
        query = self.search_var.get().lower()
        self._visible_ids: list[str] = []
        select_idx = None

        for song_id, song in self.songs.items():
            label = song.get("title") or song_id
            if query and query not in label.lower() and query not in song_id.lower():
                continue
            idx = len(self._visible_ids)
            self.listbox.insert("end", label)
            self._visible_ids.append(song_id)
            if song_id == (keep_selection or self.current_id):
                select_idx = idx

        if select_idx is not None:
            self.listbox.selection_set(select_idx)
            self.listbox.see(select_idx)

    def _filter_list(self):
        self._refresh_list()

    def _on_select(self, _event=None):
        sel = self.listbox.curselection()
        if not sel:
            return
        song_id = self._visible_ids[sel[0]]
        if song_id == self.current_id:
            return
        if self.field_dirty:
            ans = messagebox.askyesnocancel(
                "Unsaved changes",
                "Current song has unsaved changes. Apply them before switching?")
            if ans is None:
                # cancel → re-select current
                self._refresh_list()
                return
            if ans:
                self.apply_changes()
        self._load_song(song_id)

    def _load_song(self, song_id: str):
        self.current_id = song_id
        song = self.songs[song_id]
        self.field_dirty = False
        self._loading = True

        for key, widget in self.fields.items():
            raw = song.get(key) or ""
            # Show the human-readable characters in the editor
            value = xml_unescape(raw) if key in _XML_ESCAPED_FIELDS else raw
            if isinstance(widget, tk.Text):
                widget.config(state="normal")
                widget.delete("1.0", "end")
                widget.insert("1.0", value)
                widget.edit_modified(False)
            else:
                widget._var.set(value)  # type: ignore[attr-defined]

        self._loading = False
        self.apply_btn.config(state="disabled")
        self.status_var.set(f"Editing: {song_id}")

    def _set_empty_state(self):
        self.current_id = None
        self.field_dirty = False
        for widget in self.fields.values():
            if isinstance(widget, tk.Text):
                widget.delete("1.0", "end")
                widget.edit_modified(False)
            else:
                widget._var.set("")  # type: ignore[attr-defined]
        self.apply_btn.config(state="disabled")

    # ------------------------------------------------------------------ #
    # Song CRUD
    # ------------------------------------------------------------------ #

    def add_song(self):
        dialog = tk.Toplevel(self)
        dialog.title("New song")
        dialog.resizable(False, False)
        dialog.grab_set()

        tk.Label(dialog, text="Title for the new song:", padx=12, pady=8).pack()
        var = tk.StringVar()
        entry = tk.Entry(dialog, textvariable=var, width=36, font=("TkDefaultFont", 11))
        entry.pack(padx=12, pady=(0, 8))
        entry.focus_set()

        def confirm():
            title = var.get().strip()
            if not title:
                messagebox.showwarning("Title required", "Please enter a title.",
                                       parent=dialog)
                return
            song_id = make_id(title, set(self.songs.keys()))
            self.songs[song_id] = {
                "id": song_id, "title": title, "alttitle": None,
                "firstline": None, "meta": None, "text": None, "notes": None,
            }
            self.dirty = True
            dialog.destroy()
            self._refresh_list(keep_selection=song_id)
            self._load_song(song_id)
            self.status_var.set(f"Added song: {song_id}")

        entry.bind("<Return>", lambda e: confirm())
        tk.Button(dialog, text="Add", command=confirm,
                  bg="#4a90d9", fg="white", relief="flat",
                  font=("TkDefaultFont", 10, "bold"), padx=16, pady=4).pack(pady=(0, 10))
        self.wait_window(dialog)

    def delete_song(self):
        if not self.current_id:
            return
        label = self.songs[self.current_id].get("title") or self.current_id
        if not messagebox.askyesno("Delete song",
                                   f"Delete {label}? This cannot be undone."):
            return
        del self.songs[self.current_id]
        self.dirty = True
        self.field_dirty = False
        self.current_id = None
        self._refresh_list()
        self._set_empty_state()
        self.status_var.set("Song deleted.")

    # ------------------------------------------------------------------ #
    # Editing
    # ------------------------------------------------------------------ #

    def _on_field_change(self, key: str):
        """Called whenever any field is edited."""
        if self.current_id is None or self._loading:
            return
        widget = self.fields[key]
        if isinstance(widget, tk.Text):
            if not widget.edit_modified():
                return
            widget.edit_modified(False)
        self.field_dirty = True
        self.apply_btn.config(state="normal")

    def apply_changes(self):
        if not self.current_id:
            return
        song = self.songs[self.current_id]
        for key, widget in self.fields.items():
            if isinstance(widget, tk.Text):
                value = widget.get("1.0", "end-1c").strip()
            else:
                value = widget._var.get().strip()  # type: ignore[attr-defined]

            if not value:
                # Empty → null in JSON (for all fields including title/text)
                song[key] = None
            elif key in _XML_ESCAPED_FIELDS:
                # Escape XML-unsafe characters before storing
                song[key] = xml_escape(value)
            else:
                song[key] = value

        # Keep id in sync if title changed
        song["id"] = self.current_id

        self.field_dirty = False
        self.dirty = True
        self.apply_btn.config(state="disabled")
        self._refresh_list()
        self.status_var.set(f"Changes applied to: {self.current_id}  (file not saved yet)")


# ------------------------------------------------------------------ #
# Entry point
# ------------------------------------------------------------------ #

if __name__ == "__main__":
    import sys

    app = SongEditor()

    # Allow passing a path as a CLI argument
    if len(sys.argv) > 1 and os.path.isfile(sys.argv[1]):
        try:
            with open(sys.argv[1], encoding="utf-8") as f:
                app.songs = json.load(f)
            app.filepath = sys.argv[1]
            app._refresh_list()
            app.status_var.set(f"Opened: {sys.argv[1]}  ({len(app.songs)} songs)")
        except Exception as exc:
            print(f"Could not open {sys.argv[1]}: {exc}", file=sys.stderr)

    app.mainloop()