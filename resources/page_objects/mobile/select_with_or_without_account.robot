*** Settings ***
Library    AppiumLibrary

*** Variables ***
${without_acc_btn}    com.android.chrome:id/signin_fre_dismiss_button
${with_acc_btn}       com.android.chrome:id/signin_fre_continue_button

*** Keywords ***
Page with or without account is loaded
    Wait Until Element Is Visible    id=${with_acc_btn}    10
    Element Should Be Visible        id=${without_acc_btn}
