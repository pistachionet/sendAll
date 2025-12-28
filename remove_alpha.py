import sys
from PIL import Image

def remove_alpha(path):
    try:
        img = Image.open(path)
        # Convert to RGB (drops alpha)
        rgb_img = img.convert('RGB')
        rgb_img.save(path, 'PNG')
        print(f"Successfully removed alpha from {path}")
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 remove_alpha.py <path>")
        sys.exit(1)
    remove_alpha(sys.argv[1])
