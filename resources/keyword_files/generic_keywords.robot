*** Settings ***
Documentation    Basic Keywords for Smoke tests
Variables    ${EXECDIR}/resources/util/variables.py
Library    Browser


*** Keywords ***
Handle New Tab Opening
    [Arguments]    ${link_selector}
    