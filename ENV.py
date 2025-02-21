import os
from dotenv import load_dotenv

load_dotenv()

TRELLO_BASE_URL=os.environ['TRELLO_BASE_URL']
TRELLO_USERNAME=os.environ['TRELLO_USERNAME']
TRELLO_PASSWORD=os.environ['TRELLO_PASSWORD']
TRELLO_API_URL=os.environ['TRELLO_API_URL']
TRELLO_API_KEY=os.environ['TRELLO_API_KEY']
TRELLO_API_TOKEN=os.environ['TRELLO_API_TOKEN']