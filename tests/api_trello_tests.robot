*** Settings ***
Library    FakerLibrary
Library    ../resources/ApiLibrary.py
Variables    ../ENV.py
Test Teardown    Teardown: Delete all boards

*** Variables ***
${ORGANIZATION_ID}
${COLOUR}    pink
${UPDATED_COLOUR}    purple
${PERMISSION_LEVEL}    org
${UPDATED_PERMISSION_LEVEL}    private

*** Test Cases ***
Create and delete Trello board
    ${ORGANIZATION_ID}    Get OrganizationId
    ${BOARD_NAME}    Uuid 4
    ${UPDATED_BOARD_NAME}    Uuid 4
    ${responsePost}    Create Board    ${TRELLO_API_KEY}    ${TRELLO_API_TOKEN}    ${BOARD_NAME}    ${COLOUR}    ${PERMISSION_LEVEL}
    ${responseGet}    Get Board    ${TRELLO_API_KEY}    ${TRELLO_API_TOKEN}    ${responsePost['id']}
    Should Be Equal    ${BOARD_NAME}    ${responseGet['name']}
    Should Be Equal    ${ORGANIZATION_ID}    ${responseGet['idOrganization']}
    ${prefs}    Set Variable    ${responseGet['prefs']}
    Should Be Equal    ${PERMISSION_LEVEL}    ${prefs['permissionLevel']}
    Should Be Equal    ${COLOUR}    ${prefs['background']}
    ${responsePut}    Update Board    ${responseGet['id']}    ${TRELLO_API_KEY}    ${TRELLO_API_TOKEN}    ${UPDATED_BOARD_NAME}    ${UPDATED_COLOUR}    ${UPDATED_PERMISSION_LEVEL}
    ${responseGetUpdated}    Get Board    ${TRELLO_API_KEY}    ${TRELLO_API_TOKEN}    ${responsePost['id']}
    Should Be Equal    ${UPDATED_BOARD_NAME}    ${responseGetUpdated['name']}
    Should Be Equal    ${ORGANIZATION_ID}    ${responseGetUpdated['idOrganization']}
    ${prefs}    Set Variable    ${responseGetUpdated['prefs']}
    Should Be Equal    ${UPDATED_PERMISSION_LEVEL}    ${prefs['permissionLevel']}
    Should Be Equal    ${UPDATED_COLOUR}    ${prefs['background']}
    Close Board    ${responsePost['id']}    ${TRELLO_API_KEY}    ${TRELLO_API_TOKEN}
    Delete Board    ${responsePost['id']}    ${TRELLO_API_KEY}    ${TRELLO_API_TOKEN}