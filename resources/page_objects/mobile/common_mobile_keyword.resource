*** Settings ***
Library     AppiumLibrary
Resource    resources/page_objects/mobile/select_with_or_without_account.robot

*** Variables ***
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   16

*** Keywords ***
Open chrome appium driver
    Open Application  http://127.0.0.1:4723/wd/hub  automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    appPackage=com.android.chrome  appActivity=com.google.android.apps.chrome.Main
    ...    deviceName=RZCX10WSYZF  autoAcceptAlerts=true  autoDismissAlerts=true  noReset=false
    ...    W3C=true

I open an android chrome web browser and go to url
    [Arguments]    ${URL}
    Open chrome appium driver
    Page with or without account is loaded
    Click Element    ${without_acc_btn}
    Wait Until Element Is Visible    id=com.android.chrome:id/ack_button
    Click Element    id=com.android.chrome:id/ack_button
    Go To Url    ${URL}
    ${contexts}    Get Contexts
    Switch To Context    WEBVIEW_chrome
    ${windows_handles}    Get Windows
    Switch To Window    ${windows_handles[0]}
