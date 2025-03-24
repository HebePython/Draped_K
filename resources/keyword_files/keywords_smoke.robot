*** Settings ***
Documentation    Basic Keywords for Smoke tests
Variables    ${EXECDIR}/resources/util/variables.py
Library    Browser



*** Keywords ***
Navigate To Menu Item And Verify
    [Arguments]    ${menu_item}    ${expected_text}

    Handle Cookie Popup

    Click    css=.cmp-navigation a:has-text("${menu_item}")
    
    Wait For Elements State    css=body    stable

    ${title}=    Get Title
    Should Contain    ${title}    ${expected_text}




Handle Cookie Popup
    [Documentation]    Handles cookie popups by rejecting them
    
    Sleep    1s
    
    # Check if cookie popup exists
    ${popup_visible}=    Get Element Count    id=onetrust-reject-all-handler
    IF    ${popup_visible} > 0
        # Use a more specific selector to target the primary reject button
        Click    id=onetrust-reject-all-handler
        Wait For Elements State    id=onetrust-reject-all-handler    detached    timeout=5s
        Log    Cookie popup handled: clicked primary "Reject All" button
    ELSE
        # Try the alternative button if the first one isn't found
        ${alt_button_visible}=    Get Element Count    css=.ot-pc-refuse-all-handler
        IF    ${alt_button_visible} > 0
            Click    css=.ot-pc-refuse-all-handler
            Wait For Elements State    css=.ot-pc-refuse-all-handler    detached    timeout=5s
            Log    Cookie popup handled: clicked secondary "Reject All" button
        ELSE
            Log    No Cookie popup detected
        END
    END