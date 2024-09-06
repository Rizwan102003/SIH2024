from flask import Flask, render_template, request, jsonify
import google.generativeai as genai
import speech_recognition as sr
import pyttsx3

app = Flask(__name__)

# Manually pass your API key here
api_key = "AIzaSyC9o-bGkOpxvbUbixbt-GL7ryplhuRqLKY"

# Configure Google AI API
genai.configure(api_key=api_key)

# Create the model configuration
generation_config = {
    "temperature": 0,
    "top_p": 0.95,
    "top_k": 64,
    "max_output_tokens": 8192,
    "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
    model_name="gemini-1.5-pro",
    generation_config=generation_config,
)

# Initialize chat history
history = []

# Function to recognize speech and convert it to text
def get_voice_input():
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        print("Listening...")
        audio = recognizer.listen(source)
        try:
            user_input = recognizer.recognize_google(audio)
            print(f"You (voice): {user_input}")
            return user_input
        except sr.UnknownValueError:
            print("Sorry, I didn't catch that. Could you repeat?")
            return None
        except sr.RequestError:
            print("Speech recognition service is unavailable.")
            return None


@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    input_mode = data.get('mode')
    
    if input_mode == 'stop':
        return jsonify({"response": "Goodbye!"})

    user_input = None

    # Voice input
    if input_mode == 'v':
        user_input = get_voice_input()
        if user_input is None:
            return jsonify({"response": "Sorry, I didn't catch that. Could you repeat?"})

    # Text input
    elif input_mode == 't':
        user_input = data.get('input')
    
    if user_input is None:
        return jsonify({"response": "Invalid input."})

    # Check for stop command
    if "stop" in user_input.lower():
        return jsonify({"response": "Goodbye!"})

    # Add user input to chat history
    history.append({"role": "user", "parts": [user_input]})

    # Create the chat session
    chat_session = model.start_chat(history=history)

    # Send user input to the AI model
    response = chat_session.send_message(user_input)
    model_response = response.text

    # Update chat history
    history.append({"role": "model", "parts": [model_response]})

    return jsonify({"response": model_response})


if __name__ == '__main__':
    app.run(debug=True)
