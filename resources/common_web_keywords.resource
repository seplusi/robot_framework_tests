*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Accept cookie
    [Arguments]    ${accept_locator}    ${not_visible_locator}
    Wait Until Element Is Visible    ${accept_locator}    10
    Click Button    ${accept_locator}
    Wait Until Element Is Not Visible    ${not_visible_locator}