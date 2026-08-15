import json
import os

RECIPES_DIR = os.path.join(os.path.dirname(__file__), "recipes")
OUTPUT = os.path.join(RECIPES_DIR, "index.json")


def main():
    files = []
    for name in sorted(os.listdir(RECIPES_DIR)):
        if not name.endswith(".md"):
            continue
        with open(os.path.join(RECIPES_DIR, name), "r", encoding="utf-8") as f:
            content = f.read()
        files.append({"name": name, "content": content})

    with open(OUTPUT, "w", encoding="utf-8") as f:
        json.dump(files, f, ensure_ascii=False, separators=(",", ":"))


if __name__ == "__main__":
    main()
