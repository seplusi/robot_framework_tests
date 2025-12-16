*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Test Teardown    Delete created object After Test

*** Variables ***
${jsonplaceholder_base_url}    https://jsonplaceholder.typicode.com
${api_dev_objects}    https://api.restful-api.dev/objects
${created_obj_id}    ${EMPTY}

*** Keywords ***
Delete created object After Test
    IF    "${created_obj_id}" != ''
        Log To Console    ${created_obj_id}
        DELETE    ${api_dev_objects}/${created_obj_id}
    END

Create object using post
    ${data}    Create Dictionary    year=2013    price=100    CPU model=Intel Core i1    Hard disk size=1 GB
    ${full_data}    Create Dictionary    name=S1    data=${data}
    ${response}    POST    ${api_dev_objects}    json=${full_data}    expected_status=200
    Set Suite Variable    ${created_obj_id}    ${response.json()['id']}

*** Test Cases ***
Test I can get 1 item by id
    ${response}    GET    ${jsonplaceholder_base_url}/posts    params=id=1    expected_status=200
    Length Should Be    ${response.json()}    1
    ${len}    Get Length    ${response.json()[0].keys()}
    Should Be Equal As Numbers    ${len}    4
    ${result}    Set Variable    ${response.json()[0]}    
    Should Contain   ${result['body']}    quia
    Should Be Equal As Integers    ${result['id']}    1
    Should Be Equal As Integers    ${result['userId']}    1
    Should Contain   ${result['title']}    sunt

Test I can get all items by userId
    ${response}    GET    ${jsonplaceholder_base_url}/posts    params=userId=1    expected_status=200
    Length Should Be    ${response.json()}    10
    @{list} = 	Create List
    FOR    ${item}    IN    @{response.json()}
        ${len}    Get Length    ${item.keys()}
        Should Be Equal As Numbers    ${len}    4
        Should Be Equal As Integers    ${item['userId']}    1
        Should Be String    ${item['title']}
        Should Be String    ${item['body']}
        ${status} = 	Evaluate 	isinstance(${item['id']}, int)
        Should Be True    ${status}
        List Should Not Contain Value    ${list}    ${item['id']}
        Append To List    ${list}    ${item['id']}
    END

Create an entry using POST and asserting response
    ${data}    Create Dictionary    year=2013    price=100    CPU model=Intel Core i1    Hard disk size=1 GB
    ${full_data}    Create Dictionary    name=S1    data=${data}
    ${response}    POST    ${api_dev_objects}    json=${full_data}    expected_status=200
    Set Suite Variable    ${created_obj_id}    ${response.json()['id']}
    Should Match Regexp    ${response.json()['id']}    pattern=^[0-9a-f]*$
    Should Be Equal    ${response.json()['name']}    S1
    Should Be Equal    ${response.json()['data']}    ${data}
    Log To Console    ${response.text}

Validate created object by issuing a GET
    ${data}    Create Dictionary    year=2013    price=100    CPU model=Intel Core i1    Hard disk size=1 GB
    Create object using post
    ${response}    GET    ${api_dev_objects}/${created_obj_id}    expected_status=200
    Should Match Regexp    ${response.json()['id']}    ^[0-9a-f]*$
    Should Be Equal    ${response.json()['name']}    S1
    Should Be Equal    ${response.json()['data']}    ${data}

Update object data by using PUT
    ${data}    Create Dictionary    year=2013    price=100    CPU model=Intel Core i1    Hard disk size=1 GB
    Create object using post
    ${response}    GET    ${api_dev_objects}/${created_obj_id}    expected_status=200
    Should Match Regexp    ${response.json()['id']}    ^[0-9a-f]*$
    Should Be Equal    ${response.json()['name']}    S1
    Should Be Equal    ${response.json()['data']}    ${data}
    ${chg_data}    Create Dictionary    year=2014    price=150    CPU model=Intel Core i2    Hard disk size=1 GB
    ${full_chg_data}    Create Dictionary    name=S1    data=${chg_data}
    ${response}    PUT    ${api_dev_objects}/${created_obj_id}    json=${full_chg_data}    expected_status=200
    Should Be Equal    ${response.json()['id']}    ${created_obj_id}
    Should Be Equal    ${response.json()['name']}    S1
    Should Be Equal    ${response.json()['data']}    ${chg_data}

Update object data by using PATCH
    ${data}    Create Dictionary    year=2013    price=100    CPU model=Intel Core i1    Hard disk size=1 GB
    Create object using post
    ${response}    GET    ${api_dev_objects}/${created_obj_id}    expected_status=200
    Should Match Regexp    ${response.json()['id']}    ^[0-9a-f]*$
    Should Be Equal    ${response.json()['name']}    S1
    Should Be Equal    ${response.json()['data']}    ${data}
    ${full_chg_data}    Create Dictionary    name=S2    data=${data}
    ${response}    PATCH    ${api_dev_objects}/${created_obj_id}    json=${full_chg_data}    expected_status=200
    Should Be Equal    ${response.json()['id']}    ${created_obj_id}
    Should Be Equal    ${response.json()['name']}    S2
    Should Be Equal    ${response.json()['data']}    ${data}

Delete created object by using DELETE
    ${data}    Create Dictionary    year=2013    price=100    CPU model=Intel Core i1    Hard disk size=1 GB
    Create object using post
    ${response}    GET    ${api_dev_objects}/${created_obj_id}    expected_status=200
    Should Match Regexp    ${response.json()['id']}    ^[0-9a-f]*$
    Should Be Equal    ${response.json()['name']}    S1
    Should Be Equal    ${response.json()['data']}    ${data}
    ${response}    DELETE    ${api_dev_objects}/${created_obj_id}    expected_status=200
    Should Be Equal    "${response.json()}"    "{'message': 'Object with id = ${created_obj_id} has been deleted.'}"
    Set Suite Variable    ${created_obj_id}    ${EMPTY}