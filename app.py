from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
import numpy as np
import os

# Initialize Flask app
app = Flask(__name__)

# Load the trained model
model = load_model('skin_condition_classifier.h5')

# Define the class labels manually or using a data generator
class_labels = {
    0: 'acne',
    1: 'bags',
    2: 'redness'
}

# Function to preprocess the image
def prepare_image(img_path, img_height=180, img_width=180):
    img = image.load_img(img_path, target_size=(img_height, img_width))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)  # Convert to batch format
    img_array /= 255.0  # Rescale to [0, 1]
    return img_array

# Default route to test if the app is running
@app.route('/')
def home():
    return "Flask app is running!"

# Route for making predictions
@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    # Save the uploaded image to a temporary file
    temp_img_path = os.path.join("temp_image.jpg")
    file.save(temp_img_path)

    # Preprocess the image
    img = prepare_image(temp_img_path)

    # Make a prediction
    prediction = model.predict(img)
    predicted_class = np.argmax(prediction, axis=1)[0]

    # Get the label of the predicted class
    predicted_label = class_labels.get(predicted_class, "Unknown")

    # Delete the temporary image file
    os.remove(temp_img_path)

    # Return the result as JSON
    return jsonify({"predicted_label": predicted_label})

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True, port=5001)  # Or whichever port you prefer
