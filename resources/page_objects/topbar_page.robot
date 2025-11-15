*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Topbar selectors
${topbar_title}       css:span[class*="topbar-header"] > h6
${topbar_upgr_btn}    css:div[class*="oxd-topbar-header"] button[class*="upgrade"]
${dropdown_name}      css:span[class*="userdropdown-tab"] > p
${dropdown_img}       css:span[class*="userdropdown-tab"] > img
${dropdown_caret}     css:span[class*="userdropdown-tab"] > i

*** Keywords ***
Topbar page is loaded
    Wait Until Element Is Visible    ${topbar_title}    10
    Element Should Be Visible        ${topbar_upgr_btn}
    Element Should Be Visible        ${dropdown_name}
    Element Should Be Visible        ${dropdown_img}
    Element Should Be Visible        ${dropdown_caret}
