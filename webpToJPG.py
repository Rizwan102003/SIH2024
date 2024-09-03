#from chatterbot import ChatBot
#from chatterbot.trainers import ListTrainer
#import pandas as pd

# Create a chatbot instance
#chatbot = ChatBot('HealthBot')

# Initialize the trainer
#trainer = ListTrainer(chatbot)

# Load CSV files and create training data
#symptom_description = pd.read_csv(r'C:\Users\sharn\Desktop\hackHeritage\symptom_Description.csv')
#symptom_precaution = pd.read_csv(r'C:\Users\sharn\Desktop\hackHeritage\symptom_precaution.csv')
#dataset = pd.read_csv(r'C:\Users\sharn\Desktop\hackHeritage\dataset.csv')

# Training the bot with symptom descriptions
#for index, row in symptom_description.iterrows():
 #   symptom = row['Symptom']
  #  description = row['Description']
   # trainer.train([symptom, description])

# Training the bot with symptom precautions
#for index, row in symptom_precaution.iterrows():
 #   symptom = row['Symptom']
  #  precaution = row['Precaution_1']  # You can add other precaution columns as well
   # trainer.train([symptom, precaution])

# Training the bot with dataset.csv if it contains dialogue pairs
#for index, row in dataset.iterrows():
 #   trainer.train([row['User Input'], row['Bot Response']])

# Test the chatbot
#response = chatbot.get_response("Tell me about headache")
#print(response)
#    # # # ##  ## # # # # # # # # # # # # # #  ## # # # #  # # # # # # # # #  ## # # # # # #  ## # # #  ## # #  #

from PIL import Image
import imageio

#avif to jpeg
#avif_file_name = r'C:\Users\sharn\Desktop\hackHeritage\dataset\rash\gettyimages-922607396-1613689043.avif'
#jpeg_file_name = r'C:\Users\sharn\Desktop\hackHeritage\dataset\rash\rrrash.jpeg'
#img = imageio.imread(avif_file_name)
#img_pillow = Image.fromarray(img)
#img_pillow = img_pillow.convert('RGB')
#img_pillow.save(jpeg_file_name, 'JPEG')
#print("Conversion complete!")


#webp to jpeg
webp_file_name = r'C:\Users\sharn\Desktop\hackHeritage\dataset\scabies\scabies_lesions_750.webp'
jpeg_file_name = r'C:\Users\sharn\Desktop\hackHeritage\dataset\scabies\scabies_lesions_750.jpg'
img = Image.open(webp_file_name)
img = img.convert('RGB')
img.save(jpeg_file_name, 'JPEG')

print(f"Conversion complete! JPEG saved as {jpeg_file_name}")

