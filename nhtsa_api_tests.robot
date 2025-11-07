*** Settings ***
Library    String
Library    Dialogs
Library    ./lib/CustomLib.py

*** Variables ***
${NHTSA_URL}    https://api.nhtsa.gov

*** Test Cases ***
Create A Random String
    Log To Console    We are going to generate a random string
    ${variable} =    Generate Random String    10
    Log To Console    Generated string is ${variable}

User Input Example
    ${user_name} =    Get Value From User    Please enter your name:    Default Name
    Log To Console    Hello, ${user_name}!
    ${password} =    Get Value From User    Enter your password:    hidden=True
    Log To Console    Password received (but not displayed for security).

Perform a get API call and validate
    ${response}     Make Get Request    ${NHTSA_URL}/SafetyRatings/modelyear/2013/make/Acura/model/rdx    {'format': 'json'}
    Should Be Equal As Integers   ${response.status_code}    200
    ${json_object}=    Evaluate    json.loads('''${response.text}''')    json
    ${len}    Get Length    ${json_object.keys()}
    Should Be Equal As Integers    ${len}    3
    Should Be Equal As Strings    ${json_object.keys()}    dict_keys(['Count', 'Message', 'Results'])
    Should Be Equal As Integers    ${json_object['Count']}    2
    Should Be Equal As Strings    ${json_object['Message']}    Results returned successfully
    Length Should Be    ${json_object['Results']}    2
    Should Be Equal As Strings    ${json_object['Results'][0]}    {'VehicleDescription': '2013 Acura RDX SUV 4WD', 'VehicleId': 7731}
    Should Be Equal As Strings    ${json_object['Results'][1]}    {'VehicleDescription': '2013 Acura RDX SUV FWD', 'VehicleId': 7520}

Perform a get API call with many params and validate
    ${params} =    Create Dictionary    format=json    modelYear=2012    make=acura    model=rdx
    ${response}    Make Get Request    ${NHTSA_URL}/recalls/recallsByVehicle    ${params}
    Should Be Equal As Integers   ${response.status_code}    200
    ${json_object}=    Evaluate    json.loads('''${response.text}''')    json
    ${len}    Get Length    ${json_object.keys()}
    Should Be Equal As Integers    ${len}    3
    Should Be Equal As Strings    ${json_object.keys()}    dict_keys(['Count', 'Message', 'results'])
    Should Be Equal As Integers    ${json_object['Count']}    2
    Should Be Equal As Strings    ${json_object['Message']}    Results returned successfully
    Length Should Be    ${json_object['results']}    2
    Should Be Equal As Strings    ${json_object['results'][0]['ModelYear']}    2012
    Should Be Equal As Strings    ${json_object['results'][1]['ModelYear']}    2012
    Should Be Equal As Strings    ${json_object['results'][0]['Make']}    ACURA
    Should Be Equal As Strings    ${json_object['results'][1]['Make']}    ACURA
    Should Be Equal As Strings    ${json_object['results'][0]['Model']}    RDX
    Should Be Equal As Strings    ${json_object['results'][1]['Model']}    RDX
