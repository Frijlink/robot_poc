*** Settings ***
Library   Browser
Variables    ../ENV.py

*** Keywords ***
Open Page
    New Page    ${TRELLO_BASE_URL}

Login
    Click    css=header a[class^=\"Buttonsstyles__Button\"][href*=\"login?application=trello\"]
    Fill Text    data-testid=username    ${TRELLO_USERNAME}
    Click    css=button#login-submit
    Fill Text    data-testid=password    ${TRELLO_PASSWORD}
    Click    css=button#login-submit
    Get Text    css=.boards-page-section-header-name    contains    YOUR WORKSPACES

Create New Board
    [Arguments]    ${board_name}    ${background_colour}
    Click    data-testid=create-board-tile
    Click    css=[title="${background_colour}"]
    Fill Text    data-testid=create-board-title-input    ${board_name}
    Wait For Elements State    data-testid=create-board-submit-button    attached
    Click    data-testid=create-board-submit-button
    Get Text    data-testid=board-name-display    contains    ${board_name}

Update Board
    [Arguments]    ${board_name}
    Click    data-testid=board-name-display
    Clear Text    data-testid=board-name-input
    Fill Text    data-testid=board-name-input    ${board_name}
    Keyboard Key    press    Enter

Close Board
    Hover    css=[aria-label*="(currently active)"]
    Click    css=[aria-label="Board actions menu"]
    Click    css=[aria-label="Close board"]
    Click    data-testid=popover-close-board-confirm
    Get Text    css=#content-wrapper p    contains    This board is closed. Reopen the board to make changes.

Delete Board
    Click    css=[aria-label="Show menu"]
    Click    data-testid=close-board-delete-board-button
    Click    data-testid=close-board-delete-board-confirm-button

Check Board Deleted
    Click    css=[aria-label="Back to home"]
    Get Element Count    css=.board-tile-details-name    ==    0