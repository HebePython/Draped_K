*** Settings ***
Documentation    Tests for basic functions of website
Library    Browser
Resource    ${EXECDIR}/resources/keyword_files/keywords_smoke.robot
Resource    ${EXECDIR}/resources/keyword_files/keywords_tests_setup.robot
Suite Setup    Setup Suite
Test Setup     Setup Test
Test Teardown    Teardown Test
Suite Teardown    Teardown Suite


*** Test Cases ***
Open Home Page
    [Documentation]    Checks if home page is accessible.
    [Tags]    smoke-test
    Get Title    ==    volvogroup
    Take Screenshot



