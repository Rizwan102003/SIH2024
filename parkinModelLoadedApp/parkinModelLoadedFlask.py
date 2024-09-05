from flask import Flask, request, render_template, jsonify
import numpy as np
import joblib

app = Flask(__name__)

# Load the model and scaler
model = joblib.load('parkinson_model.pkl')
scaler = joblib.load('scaler.pkl')

@app.route('/')
def index():
    return render_template('parkinson_form.html')

@app.route('/predict', methods=['POST'])
def predict():
    # Get data from form
    MDVP_Fo = float(request.form['MDVP_Fo'])
    MDVP_Fhi = float(request.form['MDVP_Fhi'])
    MDVP_Flo = float(request.form['MDVP_Flo'])
    MDVP_Jitter_percent = float(request.form['MDVP_Jitter_percent'])
    MDVP_Jitter_Abs = float(request.form['MDVP_Jitter_Abs'])
    MDVP_RAP = float(request.form['MDVP_RAP'])
    MDVP_PPQ = float(request.form['MDVP_PPQ'])
    Jitter_DDP = float(request.form['Jitter_DDP'])
    MDVP_Shimmer = float(request.form['MDVP_Shimmer'])
    MDVP_Shimmer_dB = float(request.form['MDVP_Shimmer_dB'])
    Shimmer_APQ3 = float(request.form['Shimmer_APQ3'])
    Shimmer_APQ5 = float(request.form['Shimmer_APQ5'])
    MDVP_APQ = float(request.form['MDVP_APQ'])
    Shimmer_DDA = float(request.form['Shimmer_DDA'])
    NHR = float(request.form['NHR'])
    HNR = float(request.form['HNR'])
    RPDE = float(request.form['RPDE'])
    DFA = float(request.form['DFA'])
    spread1 = float(request.form['spread1'])
    spread2 = float(request.form['spread2'])
    D2 = float(request.form['D2'])
    PPE = float(request.form['PPE'])

    # Prepare input data for prediction
    input_data = (MDVP_Fo, MDVP_Fhi, MDVP_Flo, MDVP_Jitter_percent, MDVP_Jitter_Abs, 
                  MDVP_RAP, MDVP_PPQ, Jitter_DDP, MDVP_Shimmer, MDVP_Shimmer_dB, 
                  Shimmer_APQ3, Shimmer_APQ5, MDVP_APQ, Shimmer_DDA, NHR, HNR, 
                  RPDE, DFA, spread1, spread2, D2, PPE)

    input_data_as_numpy_array = np.asarray(input_data).reshape(1, -1)

    # Scale the input data
    input_data_scaled = scaler.transform(input_data_as_numpy_array)

    # Make prediction
    prediction = model.predict(input_data_scaled)

    result = 'This person has Parkinson\'s disease' if prediction[0] == 1 else 'This person does not have Parkinson\'s disease'

    return jsonify({'prediction': result})

if __name__ == '__main__':
    app.run(debug=True)
