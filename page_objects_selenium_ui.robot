*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser with url and maximize    ${URL}    chrome
Test Teardown    Close Browser
Resource    resources/page_objects/login_page.robot
Resource    resources/page_objects/topbar_page.robot
Resource    resources/page_objects/sidebar_page.robot
Resource    resources/page_objects/dashboard_page.robot

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

Perform successful login
    Login Page is loaded
    Input Text    ${login_username_input_box}    Admin
    Input Text    ${login_passwd_input_box}    admin123
    Click Element    ${submit_btn}
    Wait Until Element Is Not Visible    ${submit_btn}
    Topbar page is loaded
    Sidebar page is loaded
    Dashboard page is loaded

Perform successful login using page object method
    Login Page is loaded
    Perform a Valid Login    user=Admin    password=admin123
    Topbar page is loaded
    Sidebar page is loaded
    Dashboard page is loaded

Validate landidng page after successful login
    Login Page is loaded
    Input Text    ${login_username_input_box}    Admin
    Input Text    ${login_passwd_input_box}    admin123
    Click Element    ${submit_btn}
    Topbar page is loaded
    Sidebar page is loaded
    Dashboard page is loaded
    Element Text Should Be    ${topbar_title}    Dashboard
    Element Text Should Be    ${topbar_upgr_btn}    Upgrade
    ${element_text}=    Get Text    ${dropdown_name}
    Should Match Regexp 	${element_text} 	^[a-zA-Z\\s]*$
    Element Attribute Value Should Be    ${sidebar_search_box}    placeholder    Search
    Element Text Should Be    ${sidebar_admin_btn}    Admin
    Element Text Should Be    ${sidebar_pim_btn}    PIM
    Element Text Should Be    ${sidebar_leave_btn}    Leave
    Element Text Should Be    ${sidebar_time_btn}    Time
    Element Text Should Be    ${sidebar_hire_btn}    Recruitment
    Element Text Should Be    ${sidebar_my_det_btn}    My Info
    Element Text Should Be    ${sidebar_perf_btn}    Performance
    Element Text Should Be    ${sidebar_dash_btn}    Dashboard
    Element Text Should Be    ${sidebar_mntn_btn}    Maintenance
    Element Text Should Be    ${sidebar_claim_btn}    Claim
    Element Text Should Be    ${sidebar_buzz_btn}    Buzz
