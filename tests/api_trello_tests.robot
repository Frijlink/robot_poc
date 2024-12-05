*** Settings ***
Library    Collections
Library    ../resources/ApiLibrary.py

*** Test Cases ***
My First Library Test
    # # GET Member ID
    ${member_id}    GET MemberId
    # GET Organization ID
    ${org_id}    GET OrganizationId    ${member_id}
    Log    ${org_id}

# TODO: CRUD