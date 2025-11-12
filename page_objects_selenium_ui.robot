*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser with url and maximize    ${URL}    chrome
Test Teardown    Close Browser
Resource    resources/page_objects/login_page.robot

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

*** Keywords ***
Open Browser with url and maximize
    [Arguments]    ${URL}    ${browser}
    Open Browser    ${URL}    ${browser}
    Maximize Browser Window

Perform Invalid Login
    [Arguments]   ${username}   ${password}
    Login Page is loaded
    Input Text    ${login_username_input_box}    ${username}
    Input Text    ${login_passwd_input_box}    ${password}
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${invalid_credentials_err}
    Element Text Should Be    ${invalid_credentials_err}    Invalid credentials
    Login Page is loaded


*** Test Cases ***
Validate Login Page
    Login Page is loaded
    Element Text Should Be    ${login_title}    Login
    Element Text Should Be    ${username_label}    Username
    Element Text Should Be    ${passwd_label}    Password
    Element Attribute Value Should Be    ${login_username_input_box}    placeholder    Username
    Element Attribute Value Should Be    ${login_passwd_input_box}    placeholder    Password
    Element Text Should Be    ${submit_btn}    Login
    Element Text Should Be    ${forgot_pwd_lnk}    Forgot your password? 

Perform successful login
    Login Page is loaded
    Input Text    ${login_username_input_box}    Admin
    Input Text    ${login_passwd_input_box}    admin123
    Click Element    ${submit_btn}
    Wait Until Element Is Not Visible    ${submit_btn}

Test unsuccessful login
    Login Page is loaded
    Input Text    ${login_username_input_box}    blah
    Input Text    ${login_passwd_input_box}    admin123
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${invalid_credentials_err}
    Element Text Should Be    ${invalid_credentials_err}    Invalid credentials
    Login Page is loaded

Test missing both credentials
    Login Page is loaded
    Input Text    ${login_username_input_box}    ${EMPTY}
    Input Text    ${login_passwd_input_box}    ${EMPTY}
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${username_err}
    Element Text Should Be    ${username_err}    Required
    Element Text Should Be    ${passwd_err}    Required
    Login Page is loaded

    