import json
import os
import re

partitions = [
    "Gasquesånger",
    "Datasånger",
    "Sektionssånger",
    "Sånger till Ölet",
    "Sånger till Vinet",
    "Punschvisor",
    "Nubbevisor",
    "Dagen efter",
    "Traditionellt",
    "Högtid",
    "Säsånger",
    "Roliga Sånger",
    "Mottagningssånger"
]

def clean_text(text):
    """Cleans up carriage returns and standardizes spacing."""
    if not text:
        return ""
    # Replace \r\n with standard \n
    text = text.replace("\r\n", "\n")

    replacements = {
        "\\": "\\\\",
        "#": "\\#",
        "[": "\\[",
        "]": "\\]",
        "*": "\\*",
        "_": "\\_",
    }

    for old, new in replacements.items():
        text = text.replace(old, new)
    # Strip leading/trailing whitespace but preserve internal structure
    return text.strip()

def generate_typst_song(song_data):
    """Generates Typst markup string from song data."""
    title = song_data.get("title", "")
    firstline = song_data.get("firstline", "")
    meta = clean_text(song_data.get("meta", ""))
    text = clean_text(song_data.get("text", ""))
    
    # 1. Start the song block
    typst_content = f'#import "template.typ": songbook, song, songmeta, songtext\n\n#song(title: "{title}")[\n'
    
    # 2. Add metadata block if it exists
    if meta:
        typst_content += "  #songmeta[\n"
        # Indent meta lines for clean output
        for line in meta.split("\n"):
            typst_content += f"    {line} \\ \n"
        typst_content += "  ]\n\n"
        
    # 3. Add the song text block
    typst_content += "  #songtext[\n"
    # Indent the text blocks for readability within Typst
    for line in text.split("\n"):
        if line.strip() == "":
            typst_content += "\n"  # Keep paragraph breaks
        else:
            typst_content += f"    {line} \\ \n"
    typst_content += "  ]\n"
    
    # 4. Close the song block
    typst_content += "]\n"
    
    return typst_content

def process_json_folder(input_dir="songs_json", output_dir="output_songs"):
    """Reads a directory of individual JSON files and writes Typst files."""
    # Ensure directories exist
    os.makedirs(output_dir, exist_ok=True)
    
    if not os.path.exists(input_dir):
        print(f"Error: Input directory '{input_dir}' does not exist.")
        return

    # Filter and find all json files in the input folder
    json_files = [f for f in os.listdir(input_dir) if f.lower().endswith('.json')]
    
    if not json_files:
        print(f"No JSON files found in '{input_dir}'.")
        return

    print(f"Found {len(json_files)} JSON file(s) to process.\n")

    for file_name in json_files:
        json_file_path = os.path.join(input_dir, file_name)
        
        try:
            with open(json_file_path, 'r', encoding='utf-8') as f:
                song_data = json.load(f)
            
            # Use file name (minus extension) as a fallback ID if 'id' is missing
            fallback_id = os.path.splitext(file_name)[0]
            
            # If the file accidentally contains a list, handle the first item
            if isinstance(song_data, list):
                if len(song_data) > 0:
                    song_data = song_data[0]
                else:
                    print(f"Skipping empty list file: {file_name}")
                    continue
            
            song_id = song_data.get("id", fallback_id)
            song_partition = song_data.get("partition", 0)
            partition = partitions[song_partition]
            typst_markup = generate_typst_song(song_data)
            
            # Define output filename
            filename = f"{partition}/{song_id}.typ"
            file_path = os.path.join(output_dir, filename)
            
            with open(file_path, 'w', encoding='utf-8') as out_file:
                out_file.write(typst_markup)
                
            print(f"Generated: {file_path}")
            
        except json.JSONDecodeError:
            print(f"Error decoding JSON in file: {file_name}")
        except Exception as e:
            print(f"An error occurred processing {file_name}: {e}")

if __name__ == "__main__":
    # Specify the directory containing your individual JSON song files
    input_folder = "jsongs" 
    output_folder = "songs_typst"
    
    process_json_folder(input_folder, output_folder)
