import google.generativeai as genai
import speech_recognition as sr
import pyttsx3

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


# Initialize chat history
history = []
print("Bot: Hello, how can I help you?")

while True:
    # Ask the user whether they want to use voice or text
    input_mode = input("Choose interaction mode (type 'v' for voice, 't' for text, 'stop' to quit): ").strip().lower()

    if input_mode == 'stop':
        print("Bot: Goodbye!")
        break

    # Voice input
    if input_mode == 'v':
        user_input = get_voice_input()
        if user_input is None:
            continue

    # Text input
    elif input_mode == 't':
        user_input = input("You (type): ")
        print(f"You (type): {user_input}")

    else:
        print("Invalid choice. Please select 'v' for voice or 't' for text.")
        continue

    # Check for stop command
    if "stop" in user_input.lower():
        print("Bot: Goodbye!")
        break

    # Create the chat session
    chat_session = model.start_chat(history=history)

    # Send user input to the AI model
    response = chat_session.send_message(user_input)
    model_response = response.text

    # Print the response (only text output)
    print(f"Bot: {model_response}")

    # Update chat history
    history.append({"role": "user", "parts": [user_input]})
    history.append({"role": "model", "parts": [model_response]})