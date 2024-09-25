*** Settings ***
Resource    ../keywords/ui_keywords.robot

*** Variables ***
${BOARD_NAME}    Uuid 4
${UPDATED_BOARD_NAME}    Uuid 4

*** Test Cases ***
Create And Delete Trello Board
    Open Page
    Login
    Create New Board    ${BOARD_NAME}    🌈
    Update Board    ${UPDATED_BOARD_NAME}
    Close Board
    Delete Board
    Check Board Deleted
