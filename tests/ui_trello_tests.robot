*** Settings ***
Resource    ../resources/ui_keywords.resource
Library    ../resources/ApiLibrary.py
Library    FakerLibrary
Test Teardown    Teardown: Delete all boards

*** Variables ***
${BOARD_NAME}    Uuid 4
${UPDATED_BOARD_NAME}    Uuid 4

*** Test Cases ***
Create And Delete Trello Board through UI
    Open Page
    Login
    Create New Board    ${BOARD_NAME}    🌈
    Update Board    ${UPDATED_BOARD_NAME}
    Close Board
    Delete Board
    Check Board Deleted
