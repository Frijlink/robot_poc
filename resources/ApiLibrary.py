from robot.api.deco import keyword
from ENV import *
import requests

class ApiLibrary:
    @keyword("GET MemberId")
    def get_member_id(self):
        url = f"{TRELLO_API_URL}/1/tokens/{TRELLO_API_TOKEN}?key={TRELLO_API_KEY}&token={TRELLO_API_TOKEN}"
        headers = {'accept': 'application/json'}
        response = requests.get(url, headers=headers)
        json = response.json()

        return json['idMember']

    @keyword("GET OrganizationId")
    def get_organization_id(self, member_id):
        url = f"{TRELLO_API_URL}/1/members/{member_id}/organizations?key={TRELLO_API_KEY}&token={TRELLO_API_TOKEN}"
        headers = {'accept': 'application/json'}
        response = requests.get(url, headers=headers)
        json = response.json()

        return json[0]['id']
