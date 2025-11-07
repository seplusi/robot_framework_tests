*** Settings ***
Library    String
Library    SeleniumLibrary
Test Setup    Open Browser with url and maximize    ${TOYOTA_URL}    chrome
Test Teardown    Close Browser

*** Variables ***
${TOYOTA_URL}    https://www.toyota.com

*** Keywords ***
Open Browser with url and maximize
    [Arguments]    ${arg1}    ${arg2}
    Open Browser    ${arg1}    ${arg2}
    Maximize Browser Window

Accept cookie
    Wait Until Element Is Visible    css:button[class="cookie-banner__accept"]    10
    Click Button    css:button[class="cookie-banner__accept"]
    Wait Until Element Is Not Visible    css:button[ria-label="Close Cookie Banner"]

*** Test Cases ***
Validate cookie page and accept it
    Wait Until Element Is Visible    css:a[data-di-id="#logo"]    10
    ${attr_name}    Get Element Attribute    css:a[data-di-id="#logo"]    data-aa-link-text
    Should Be Equal As Strings    ${attr_name}    Toyota Logo
    Wait Until Element Is Visible    css:button[class="cookie-banner__accept"]    10
    Element Text Should Be    css:button[class="cookie-banner__accept"]    Accept
    Wait Until Element Is Visible    css:button[class="cookie-banner__reject"]    10
    Element Text Should Be    css:button[class="cookie-banner__reject"]    Decline
    Wait Until Element Is Visible    css:button[aria-label="Close Cookie Banner"]
    Click Button    css:button[class="cookie-banner__accept"]
    Wait Until Element Is Not Visible    css:button[ria-label="Close Cookie Banner"]
    ${cookies}=    Get Cookies
    ${lines}    Get Regexp Matches    ${cookies}    TOYOTANATIONAL_ENSIGHTEN_PRIVACY*
    ${nr_lines}    Get Length    ${lines}
    Should Be True    ${nr_lines}>0

Validate login page
    Accept cookie
    Wait Until Element Is Visible    css:a[data-di-id="#logo"]    10
    ${attr_name}    Get Element Attribute    css:a[data-di-id="#logo"]    data-aa-link-text
    Should Be Equal As Strings    ${attr_name}    Toyota Logo
    