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
    [Documentation]    Checks if home page is accessible
    [Tags]    smoke-test
    Get Title    ==    Home | Volvo Group

Navigate To Main Menu Items
    [Documentation]    Tests navigational links
    [Tags]    smoke-test
    [Template]    Navigate To Menu Item And Verify

    # Menu item name               # Expected text in title or page
    Sustainable Transportation     Sustainable Transportation
    Careers                        careers
    Investors                      Investor
    News & Media                   News and Media
    Suppliers                      Supply Chain Partners
    About Us                       About us


Navigate Explore Image Links
    [Documentation]    Tests the 3 image links on home page
    [Tags]    smoke-test
    [Template]    Navigate To Explore Image Item And Verify

    # Explore item name            # Expected text in title or page
    Products & Services            Products and services
    Our brands                     Our Brands
    Financial reports 2023         Financial Reports

Navigate To Explore Jobs Page
    [Documentation]    Tests job page opening as a new tab
    [Tags]    smoke-test
    Open Job Page Explore Item, Verify And Close
