*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${time_work_txt}        xpath://i[contains(@class, "bi-clock")]/../p
${card_state_txt}       css:div[class="orangehrm-attendance-card-profile-record"] > p[class*="card-state"]
${card_details_txt}     css:div[class="orangehrm-attendance-card-profile-record"] > p[class*="card-details"]
${card_fulltime_txt}    css:span[class*="attendance-card-fulltime"]

*** Keywords ***
Dashboard page is loaded
    Wait Until Element Is Visible    ${time_work_txt}    10
    Wait Until Element Is Visible    ${card_state_txt}    10
    Wait Until Element Is Visible    ${card_details_txt}    10
    Wait Until Element Is Visible    ${card_fulltime_txt}    10
