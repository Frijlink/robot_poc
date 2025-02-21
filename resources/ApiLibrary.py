import os
import requests
from dotenv import load_dotenv
from robot.api.deco import keyword

load_dotenv()

class ApiLibrary:
    ##################
    ### BOARDS API ###
    ##################
    @keyword("Create Board")
    def post_boards(self, key, token, name, colour, visibility):
        body = {
            "name": name,
            "key": key,
            "token": token,
            "prefs_background": colour,
            "prefs_permissionLevel": visibility
        }
        url = f"{os.environ['TRELLO_API_URL']}/1/boards"
        response = requests.post(url, json=body)
        assert response.ok, f"Request POST /boards failed: {response.reason}"
        return response.json()

    @keyword("Update Board")
    def put_boards(self, id, key, token, name, colour, visibility):
        body = {
            "name": name,
            "key": key,
            "token": token,
            "prefs/background": colour,
            "prefs/permissionLevel": visibility
        }
        url = f"{os.environ['TRELLO_API_URL']}/1/boards/{id}"
        response = requests.put(url, json=body)
        assert response.ok, f"Request PUT /boards failed: {response.reason}"
        return response.json()

    @keyword("Get Board")
    def get_board(self, key, token, board_id):
        url = f"{os.environ['TRELLO_API_URL']}/1/boards/{board_id}?key={key}&token={token}"
        response = requests.get(url)
        assert response.ok, f"Request GET /boards/{board_id} failed: {response.reason}"
        return response.json()

    @keyword("Close Board")
    def close_board(self, board_id, key, token):
        body = {
            "key": key,
            "token": token,
            "closed": True
        }
        url = f"{os.environ['TRELLO_API_URL']}/1/boards/{board_id}"
        response = requests.put(url, json=body)
        assert response.ok, f"Request PUT /boards to close failed: {response.reason}"
        return response.json()

    @keyword("Delete Board")
    def delete_board(self, board_id, key, token):
        url = f"{os.environ['TRELLO_API_URL']}/1/boards/{board_id}?key={key}&token={token}"
        response = requests.delete(url)
        assert response.ok, f"Request DELETE /boards failed: {response.reason}"
        return response.json()

    ###################
    ### MEMBERS API ###
    ###################
    @keyword("GET MemberId")
    def get_member_id(self):
        url = f"{os.environ['TRELLO_API_URL']}/1/tokens/{os.environ['TRELLO_API_TOKEN']}?key={os.environ['TRELLO_API_KEY']}&token={os.environ['TRELLO_API_TOKEN']}"
        headers = {'accept': 'application/json'}
        response = requests.get(url, headers=headers)
        assert response.ok, "Request GET /tokens failed"
        json = response.json()
        return json['idMember']

    @keyword("Get OrganizationId")
    def get_organization_id(self):
        member_id = self.get_member_id()
        url = f"{os.environ['TRELLO_API_URL']}/1/members/{member_id}/organizations?key={os.environ['TRELLO_API_KEY']}&token={os.environ['TRELLO_API_TOKEN']}"
        headers = {'accept': 'application/json'}
        response = requests.get(url, headers=headers)
        assert response.ok, "Request GET /members/\{id\}/organizations failed"
        json = response.json()
        return json[0]['id']

    @keyword("Get Boards")
    def get_boards(self, key, token):
        url = f"{os.environ['TRELLO_API_URL']}/1/members/me/boards?key={key}&token={token}"
        response = requests.get(url)
        assert response.ok, f"Request GET /members/me/boards failed: {response.reason}"
        return response.json()

    @keyword("Teardown: Delete all boards")
    def delete_all_boards(self):
        key = os.environ['TRELLO_API_KEY']
        token = os.environ['TRELLO_API_TOKEN']
        boards = self.get_boards(key, token)
        for board in boards:
            self.delete_board(board['id'], key, token)
