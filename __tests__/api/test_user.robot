*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}           https://petstore.swagger.io/v2/user
${id}            1
${username}      kroger
${firstName}     Thomas
${lastName}      Mann
${email}         zarasenna9@gmail.com
${password}      soeuseiquesei
${phone}
${userStatus}    1
${code}          200
${type}          unknown

*** Test Cases ***

Post User
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    lastName=${lastName}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}

    ${response}    POST    url=${url}    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(${code})}}
    Should Be Equal    ${response_body}[type]       ${type}
    Should Be Equal    ${response_body}[message]    ${id}

Get User
    ${response}    GET    url=${url}/${username}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[username]      ${username}
    Should Be Equal    ${response_body}[firstName]     ${firstName}
    Should Be Equal    ${response_body}[lastName]      ${lastName}
    Should Be Equal    ${response_body}[email]         ${email}  
    Should Be Equal    ${response_body}[password]      ${password}  
    Should Be Equal    ${response_body}[userStatus]    ${{int(${userStatus})}}

Put User
    ${body}    Evaluate    json.loads(open('./fixtures/json/user.json').read())

    ${response}    PUT    url=${url}/${username}    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(${code})}}
    Should Be Equal    ${response_body}[type]    ${type}
   
Delete User
    ${response}    DELETE    url=${url}/${username}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(${code})}}
    Should Be Equal    ${response_body}[type]       ${type}
    Should Be Equal    ${response_body}[message]    ${username}

     