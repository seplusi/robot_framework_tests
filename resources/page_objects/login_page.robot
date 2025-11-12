*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${login_brand_img}    css:div[class*="login-branding"] > img
${login_title}    css:h5
${username_label}    css:form[class="oxd-form"] > div[class="oxd-form-row"]:nth-of-type(1) label
${passwd_label}    css:form[class="oxd-form"] > div[class="oxd-form-row"]:nth-of-type(2) label
${login_username_input_box}    css:input[placeholder="Username"]
${login_passwd_input_box}    css:input[placeholder="Password"]
${submit_btn}    css:button[type="submit"]
${forgot_pwd_lnk}    css:p[class*="login-forgot-header"]
${invalid_credentials_err}    css:p[class*="oxd-alert-content-text"]
${username_err}    css:div[class="oxd-form-row"]:nth-of-type(1) span[class*="oxd-input-field-error-message"]
${passwd_err}    css:div[class="oxd-form-row"]:nth-of-type(2) span[class*="oxd-input-field-error-message"]

*** Keywords ***
Login Page is loaded
    Wait Until Element Is Visible    ${login_brand_img}    10
    Element Should Be Visible    ${login_title}
    Element Should Be Visible    ${username_label}
    Element Should Be Visible    ${passwd_label}
    Element Should Be Visible    ${login_username_input_box}
    Element Should Be Visible    ${login_passwd_input_box}
    Element Should Be Visible    ${submit_btn}
    Element Should Be Visible    ${forgot_pwd_lnk}

Perform Invalid Login
    [Arguments]   ${user_csv}   ${passwd_csv}
    Login Page is loaded
    Input Text    ${login_username_input_box}    ${user_csv}
    Input Text    ${login_passwd_input_box}    ${passwd_csv}
    Click Element    ${submit_btn}
    Wait Until Element Is Visible    ${invalid_credentials_err}
    Element Text Should Be    ${invalid_credentials_err}    Invalid credentials
    Login Page is loaded
