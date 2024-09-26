*** Settings ***
Library    Collections
Library    RequestsLibrary    # http://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html
Variables    ../ENV.py

*** Variables ***
${base_url}    ${TRELLO_API_URL}
&{headers}    Accept=application/json
&{key_token_params}    key=${TRELLO_API_KEY}    token=${TRELLO_API_TOKEN}

# TODO: it looks horrible. Probably better to create the keywords in python and here just call the keywords
*** Test Cases ***
Get Member ID
    Create Session    api_session    ${base_url}

    # # GET Member ID
    ${response}    GET On Session
    ...    api_session
    ...    /1/tokens/${TRELLO_API_TOKEN}
    ...    params=${key_token_params}
    ...    headers=${headers}
    ${member_id}    Set Variable    ${response.json()}[idMember]
    # GET Organization ID
    ${resp_org}    GET On Session
    ...    api_session
    ...    /1/members/${member_id}/organizations
    ...    params=${key_token_params}
    ...    headers=${headers}
    ${org_id}    Set Variable    ${resp_org.json()}[0]['id']
    Log    ${org_id}

# TODO: CRUD