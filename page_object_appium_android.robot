*** Settings ***
Library    AppiumLibrary
Resource    resources/page_objects/mobile/select_with_or_without_account.robot
Resource    resources/page_objects/mobile/common_mobile_keyword.resource
Resource    resources/page_objects/mobile/login_page.robot
Test Teardown    Close Application


*** Test Cases ***
Test login page
    I open an android chrome web browser and go to url    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
    Login Page is loaded
    Element Text Should Be    ${login_title}    Login
    Element Text Should Be    ${username_label}    Username
    Element Text Should Be    ${passwd_label}    Password
    Element Attribute Should Match    ${login_username_input_box}    placeholder    Username
    Element Attribute Should Match    ${login_passwd_input_box}    placeholder    Password
    Element Text Should Be    ${submit_btn}    Login
    Element Text Should Be    ${forgot_pwd_lnk}    Forgot your password? 

Test unsuccessful login
    I open an android chrome web browser and go to url    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
    Login Page is loaded
    Input Text    ${login_username_input_box}    blah
    Input Text    ${login_passwd_input_box}    admin123
    Hide Keyboard
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${invalid_credentials_err}    10
    Element Text Should Be    ${invalid_credentials_err}    Invalid credentials
    Login Page is loaded
