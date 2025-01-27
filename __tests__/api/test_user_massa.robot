*** Settings ***
Library    RequestsLibrary
Library    DataDriver    ../../fixtures/csv/user1.csv    dialect=excel
Test Template    Create User DDT
*** Variables ***
${content_type}    application/json
${url}   https://petstore.swagger.io/v2/user

*** Test Cases ***

Post User    ${id}    ${username}    ${firstName}    ${lastName}    ${email}    ${password}    ${phone}    ${userStatus}    

*** Keywords ***
Create User DDT
    [Arguments]    ${id}    ${username}    ${firstName}    ${lastName}    ${email}    ${password}    ${phone}    ${userStatus}   
    ${headers}    Create Dictionary    Content-Type=${content_type}
    ${id}    Convert To Integer    ${id}
    ${phone}    Convert To Integer    ${phone}
    ${userStatus}    Convert To Integer    ${userStatus}
    
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    lastName=${lastName}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}

    ${response}    POST    url=${url}    headers=${headers}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    {response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[username]    ${username}