*** Settings ***
Documentation    Basic Keywords for Smoke tests
Variables    ${EXECDIR}/resources/util/variables.py
Library    Browser

*** Keywords ***
Setup Suite
    Log    Starting test suite execution

Setup Test
    New Browser    chromium    headless=False
    New Context    viewport={"width": 1920, "height" : 1080}
    New Page    https://volvogroup.com

Teardown Test
    Close Context
    Close Browser

Teardown Suite
    Log     Finished test suite execution
