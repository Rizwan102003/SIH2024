from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import numpy as np

# Load the trained model
model = load_model('skin_condition_classifier.h5')

# Function to preprocess the image
def prepare_image(img_path, img_height, img_width):
    img = image.load_img(img_path, target_size=(img_height, img_width))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)  # Convert to batch format
    img_array /= 255.0  # Rescale to [0, 1]
    return img_array

# Set paths and parameters
img_path = r"C:\Users\sharn\Desktop\hackHeritage\modelTester\undereyes-bna-lg.jpg"  # Image to predict
dataset_path = r"C:\Users\sharn\Desktop\hackHeritage\diseasePredictionModel\skinDiseaseDataset"     # Replace with your actual dataset path

# Prepare the image
img = prepare_image(img_path, img_height=180, img_width=180)

# Make a prediction
prediction = model.predict(img)

# Get the class with the highest probability
predicted_class = np.argmax(prediction, axis=1)

# Recreate the data generator to get class labels
datagen = ImageDataGenerator(rescale=1./255)
generator = datagen.flow_from_directory(
    dataset_path,
    target_size=(180, 180),
    batch_size=32,
    class_mode='categorical'
)

# Get the class labels
class_labels = {v: k for k, v in generator.class_indices.items()}

# Print the predicted label
print(f'Predicted label: {class_labels[predicted_class[0]]}')
