from flask import Flask, request, send_file, jsonify
import os
import hashlib

app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

file_contents = {}


def hash_content(content):
    """
    Generate a SHA-256 hash for the content.
    """
    hash_object = hashlib.sha256(content)
    return hash_object.hexdigest()

def get_file_hash(file_path):
    hasher = hashlib.md5()
    with open(file_path, 'rb') as f:
        # Read and update hash string value in blocks of 4K
        for byte_block in iter(lambda: f.read(4096), b""):
            hasher.update(byte_block)
    return hasher.hexdigest()


def save_file_content(file_path):
    file_hash = get_file_hash(file_path)
    if file_hash not in file_contents:
        with open(file_path, 'rb') as f:
            file_contents[file_hash] = f.read()
    return file_hash


@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
    file.save(file_path)    
    file_hash = save_file_content(file_path)

    return jsonify({'message': 'File uploaded successfully', 'file_hash': file_hash})
     
@app.route('/retrieve/<filename>', methods=['GET'])
def retrieve_file(filename):
    file_hash = file_contents.get(filename)
    if not file_hash:
        return jsonify({'error': 'File not found'}), 404

    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    with open(file_path, 'wb') as f:
        f.write(file_contents[file_hash])

    return send_file(file_path, as_attachment=True)

@app.route('/delete/<filename>', methods=['DELETE'])
def delete_file(filename):
    file_hash = file_contents.get(filename)
    if not file_hash:
        return jsonify({'error': 'File not found'}), 404

    file_contents.pop(file_hash, None)
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    os.remove(file_path)

    return jsonify({'message': 'File deleted successfully'})

if __name__ == '__main__':
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    
    app.run(debug=True)
