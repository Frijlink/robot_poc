*** Settings ***
Library    Collections
Library    RequestsLibrary    # http://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html
Variables    ../ENV.py

*** Variables ***
${base_url}    ${TRELLO_API_URL}
&{headers}    Accept=application/json
&{key_token_params}    key=${TRELLO_API_KEY}    token=${TRELLO_API_TOKEN}

*** Test Cases ***
Get Member ID
    Create Session    api_session    ${base_url}

    # # GET Request
    ${response}    GET On Session
    ...    api_session
    ...    /1/tokens/${TRELLO_API_TOKEN}
    ...    params=${key_token_params}
    ...    headers=${headers}
    ${id}    Set Variable    ${response.json()}[idMember]
    Log    ${id}

# TODO: CRUD