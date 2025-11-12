*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser with url and maximize    ${URL}    chrome
Test Teardown    Close Browser
# Define the test template name that is going to use the csv data
Test Template    Perform Login While Missing One Credential
Resource    resources/page_objects/login_page.robot
Library    DataDriver    resources/data/user_and_passwd_data_one_is_empty.csv

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

*** Test Cases ***
Test multiple logins with missing one credential    ARG1    ARG2    ARG3


*** Keywords ***
Open Browser with url and maximize
    [Arguments]    ${URL}    ${browser}
    Open Browser    ${URL}    ${browser}
    Maximize Browser Window

Perform Login with missing credential
    [Arguments]   ${user}   ${passwd}    ${ele_err}
    Login Page is loaded
    Input Text    ${login_username_input_box}    ${user}
    Input Text    ${login_passwd_input_box}    ${passwd}
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${ele_err}
    Element Text Should Be    ${ele_err}    Required
    Login Page is loaded
    
# Define how the template is implemented. It's using an already defined keyword
Perform Login While Missing One Credential
    [Arguments]    ${user_csv}    ${passwd_csv}    ${ele_with_err}
    Perform Login with missing credential    ${user_csv}    ${passwd_csv}    ${ele_with_err}