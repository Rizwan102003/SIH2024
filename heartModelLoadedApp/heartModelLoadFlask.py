from flask import Flask, request, render_template, jsonify
import numpy as np
import joblib

app = Flask(__name__)

# Load the saved model
model = joblib.load('heart_disease_model.pkl')

@app.route('/')
def index():
    return render_template('heartDisease_form.html')

@app.route('/predict', methods=['POST'])
def predict():
    # Get data from form
    age = float(request.form['age'])
    sex = int(request.form['sex'])
    cp = int(request.form['cp'])
    trestbps = float(request.form['trestbps'])
    chol = float(request.form['chol'])
    fbs = int(request.form['fbs'])
    restecg = int(request.form['restecg'])
    thalach = float(request.form['thalach'])
    exang = int(request.form['exang'])
    oldpeak = float(request.form['oldpeak'])
    slope = int(request.form['slope'])
    ca = int(request.form['ca'])
    thal = int(request.form['thal'])

    # Prepare input data for prediction
    input_data = (age, sex, cp, trestbps, chol, fbs, restecg, thalach, exang, oldpeak, slope, ca, thal)
    input_data_as_numpy_array = np.asarray(input_data)
    input_data_reshaped = input_data_as_numpy_array.reshape(1, -1)

    # Make prediction
    prediction = model.predict(input_data_reshaped)

    result = 'Heart disease detected' if prediction[0] == 1 else 'No heart disease'

    return jsonify({'prediction': result})

if __name__ == '__main__':
    app.run(debug=True)
