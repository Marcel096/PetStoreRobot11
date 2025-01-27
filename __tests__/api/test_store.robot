# Biblioteca e Configurações
*** Settings ***
Library   RequestsLibrary

# objetos / atributos / /variáveis
*** Variables ***
${url}         https://petstore.swagger.io/v2/store/order
${id}          1
${petId}       198701
${quantity}    1
${shipDate}    2025-01-14T01:38:07.342+0000
${status}      placed
${complete}    true
${code}        200
${type}        unknown

#  Descritivo de negocio /passos de automação
*** Test Cases ***
Post Store
    ${body}    Create Dictionary    id=${id}    petId=${petId}    quantity=${quantity}    shipDate=${shipDate}    status=${status}    complete=${complete}

    ${response}    POST    url=${url}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]          ${{int(${id})}}
    Should Be Equal    ${response_body}[petId]       ${{int(${petId})}}
    Should Be Equal    ${response_body}[quantity]    ${{int(${quantity})}}
    Should Be Equal    ${response_body}[status]      ${status}
  


Get Store
# Executa
    ${response}    Get   url=${url}/${id}

# Valida
    ${response_body}    Set Variable    ${response.json()}
    Log to Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]          ${{int(${id})}}
    Should Be Equal    ${response_body}[petId]       ${{int(${petId})}}
    Should Be Equal    ${response_body}[quantity]    ${{int(${quantity})}}
    Should Be Equal    ${response_body}[status]      ${status}

Delete Store

    ${response}    DELETE    url=${url}/${id}


    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}}
    Should Be Equal    ${response_body}[type]       ${type}
    Should Be Equal    ${response_body}[message]    ${id}