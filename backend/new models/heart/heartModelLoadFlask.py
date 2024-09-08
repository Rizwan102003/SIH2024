from flask import Flask, request, render_template, jsonify
import sklearn
import numpy as np
import joblib
#SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True
app = Flask(__name__)

# Load the saved model
model = joblib.load('heart_disease_model.pkl')

# @app.route('/')
def index():
    return render_template('heartDisease_form.html')

@app.route('/predict', methods=['POST'])
def predict():
    # Get data from form
    data = request.json  # Get the data as JSON
    print(data)
    # Extract data from JSON
    age = float(data['age'])
    sex = int(data['sex'])
    cp = int(data['cp'])
    trestbps = float(data['trestbps'])
    chol = float(data['chol'])
    fbs = int(data['fbs'])
    restecg = int(data['restecg'])
    thalach = float(data['thalach'])
    exang = int(data['exang'])
    oldpeak = float(data['oldpeak'])
    slope = int(data['slope'])
    ca = int(data['ca'])
    thal = int(data['thal'])

    # Prepare input data for prediction
    input_data = (age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal)
    input_data_as_numpy_array = np.asarray(input_data)
    input_data_reshaped = input_data_as_numpy_array.reshape(1, -1)

    # Make prediction
    prediction = model.predict(input_data_reshaped)

    result = 'Heart disease detected' if prediction[0] == 1 else 'No heart disease'

    return jsonify({'prediction': result})

if __name__ == '__main__':
    app.run(debug=True, port = 5001)
