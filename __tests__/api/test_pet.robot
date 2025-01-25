*** Settings ***
# Biblioteca e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, Atributos e Variáveis

${url}    https://petstore.swagger.io/v2/pet

# Body
${id}    198701
&{category}    id=1    name=cachorro
${name}    Julien
@{photoUrls}
&{tag}    id=1    name=vacinado
@{tags}    &{tag}
${status}    available

${type}    unknown

*** Test Cases ***
# Descritivo de negócio + passos de automação

Post Pet
    # Montar a mensagem /  body
    ${body}    Create Dictionary    id=${id}    category=${category}    name=${name}    photoUrls=${photoUrls}    tags=${tags}    status=${status}

    # Executa
    ${response}    POST    url=${url}    json=${body}

    # Valida
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[tags][0][id]    ${{(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]
    Should Be Equal    ${response_body}[name]    ${name}
    Should Be Equal    ${response_body}[status]    ${status}