*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Sidebar selectors
${sidebar_header}         css:div[class*="sidepanel-header"] a
${sidebar_search_img}     css:div[class*="menu-search"] > svg
${sidebar_search_box}     css:div[class*="menu-search"] > input
${sibebar_chevron_btn}    css:div[class*="menu-search"] > button
${sidebar_admin_btn}      css:div[class*="sidepanel-body"] a[href*="Admin"]
${sidebar_pim_btn}        css:div[class*="sidepanel-body"] a[href*="Pim"]
${sidebar_leave_btn}      css:div[class*="sidepanel-body"] a[href*="Leave"]
${sidebar_time_btn}       css:div[class*="sidepanel-body"] a[href*="Time"]
${sidebar_hire_btn}       css:div[class*="sidepanel-body"] a[href*="recruitment"]
${sidebar_my_det_btn}     css:div[class*="sidepanel-body"] a[href*="viewMy"]
${sidebar_perf_btn}       css:div[class*="sidepanel-body"] a[href*="performance"]
${sidebar_dash_btn}       css:div[class*="sidepanel-body"] a[href*="dashboard"]
${sidebar_mntn_btn}       css:div[class*="sidepanel-body"] a[href*="maintenance"]
${sidebar_claim_btn}       css:div[class*="sidepanel-body"] a[href*="Claim"]
${sidebar_buzz_btn}       css:div[class*="sidepanel-body"] a[href*="Buzz"]

*** Keywords ***
Sidebar page is loaded
    Wait Until Element Is Visible    ${sidebar_header}    10
    Element Should Be Visible        ${sidebar_search_img}
    Element Should Be Visible        ${sidebar_search_box}
    Element Should Be Visible        ${sibebar_chevron_btn}
    Element Should Be Visible        ${sidebar_admin_btn}
    Element Should Be Visible        ${sidebar_pim_btn}
    Element Should Be Visible        ${sidebar_leave_btn}
    Element Should Be Visible        ${sidebar_time_btn}
    Element Should Be Visible        ${sidebar_hire_btn}
    Element Should Be Visible        ${sidebar_my_det_btn}
    Element Should Be Visible        ${sidebar_perf_btn}
    Element Should Be Visible        ${sidebar_dash_btn}
    Element Should Be Visible        ${sidebar_mntn_btn}
    Element Should Be Visible        ${sidebar_claim_btn}
    Element Should Be Visible        ${sidebar_buzz_btn}
