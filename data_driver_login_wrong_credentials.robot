*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser with url and maximize    ${URL}    chrome
Test Teardown    Close Browser
# Define the test template name that is going to use the csv data
Test Template    Perform Bad Login
Resource    resources/page_objects/login_page.robot
Library    DataDriver    resources/data/user_and_passwd_data.csv

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

*** Test Cases ***
Test multiple unsuccessfull logins    ARG1    ARG2


*** Keywords ***
Open Browser with url and maximize
    [Arguments]    ${URL}    ${browser}
    Open Browser    ${URL}    ${browser}
    Maximize Browser Window

# Define how the template is implemented. It's using an already defined keyword
Perform Bad Login
    [Arguments]    ${user_csv}    ${passwd_csv}
    Perform Invalid Login    ${user_csv}    ${passwd_csv}