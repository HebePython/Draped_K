*** Settings ***
Documentation    Basic Keywords for Smoke tests
Variables    ${EXECDIR}/resources/util/variables.py
Library    Browser
Library    Browser    enable_playwright_debug=True



*** Keywords ***
Navigate To Menu Item And Verify
    [Arguments]    ${menu_item}    ${expected_text}

    Handle Cookie Popup

    Click    css=.cmp-navigation a:has-text("${menu_item}")
    
    Wait For Elements State    css=body    stable

    ${title}=    Get Title
    Should Contain    ${title}    ${expected_text}


Open Home Page On Volvo Logo And Verify

    Click     role=link[name="Volvo Group logo"]

    Get Title    ==    Home | Volvo Group

Navigate To Explore Image Item And Verify
    [Arguments]    ${explore_item}    ${expected_text}

    Handle Cookie Popup

    Click    css=img[alt="${explore_item}"]
    Wait For Elements State    css=body    stable

    ${title}=    Get Title
    Should Contain    ${title}    ${expected_text}
    

    Open Home Page On Volvo Logo And Verify

Open Job Page Explore Item, Verify And Close

    Click    css=img[alt="Job openings"]

    Sleep    2s
    
   # Get IDs of all open pages
    ${page_ids}=    Get Page Ids
    ${list_length}=    Get Length    ${page_ids}
    Log    Found ${list_length} pages
    
    # Switch to new page
    Switch Page    ${page_ids}[0]

    Handle Cookie Popup

    ${title}=    Get Title
    Should Contain    ${title}    Jobs at Volvo Group

    Close Page

Handle Cookie Popup
    [Documentation]    Handles cookie popups by rejecting them with improved timeout handling
    
    # Wait longer for popup to appear
    Sleep    2s
    
    # Try to find cookie popup with specific selectors
    ${popup_visible}=    Run Keyword And Return Status    
    ...    Wait For Elements State    id=onetrust-banner-sdk    visible    timeout=3s
    
    IF    ${popup_visible}
        # Try multiple possible reject button selectors
        ${clicked}=    Run Keyword And Return Status    
        ...    Click    id=onetrust-reject-all-handler
        
        IF    not ${clicked}
            ${clicked}=    Run Keyword And Return Status    
        ...    Click    css=.ot-pc-refuse-all-handler
        END
        
        IF    not ${clicked}
            ${clicked}=    Run Keyword And Return Status    
        ...    Click    text="Reject All"
        END
        
        IF    not ${clicked}
            # Last resort - try to find any button containing reject or decline
            Click    css=button:has-text("Reject")
        END
        
        Log    Attempted to handle cookie popup
    ELSE
        Log    No cookie popup detected
    END
    
    # Additional wait to let any animations complete
    Sleep    1s