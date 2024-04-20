import subprocess
import sys
import re

def watch_typst(font_path, filename):
    command = f'typst compile  {filename}.typ --font-path fonts'
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")
    except FileNotFoundError:
        print("Error: 'typst' command not found. Make sure it's installed and in your PATH.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 compile.py <filename>")
    else:
        font_path = "fonts"
        filename = sys.argv[1]
        if not filename:
            print("Error: Please provide a valid filename.")
        else:
            filename = re.sub(r"\.pdf$", "", filename)
            filename = re.sub(r"\.typ$", "", filename)
            filename = re.sub(r"\.$", "", filename)
            watch_typst(font_path, filename)
            print("Compiled " + filename)
