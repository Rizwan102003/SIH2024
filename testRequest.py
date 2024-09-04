import requests

# Path to the image you want to classify
img_path = r"C:\Users\sharn\Desktop\hackHeritage\diseasePredictionModel\modelTester\woman-acne-cheek-1200x800-1-1024x683.jpg"

# Make the POST request to the Flask API
url = 'http://127.0.0.1:5001/predict'
with open(img_path, 'rb') as img_file:
    response = requests.post(url, files={'file': img_file})

# Print the result
print(response.json())
