*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary       # Import de la bibliothèque pour la manipulation JSON
Library    Collections       # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}      https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}       Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${Resource_ID}   2                                       # ID de la ressource à récupérer

*** Test Cases ***
Test 004 Requete GET Resource By ID
    &{headers}=             Create Dictionary    Authorization=Bearer ${API_KEY}
    ${Reponse}=             GET    ${Base_URL}api/unknown/${Resource_ID}    headers=${headers}    expected_status=200
    ${ReponseJson}=         Set Variable    ${Reponse.json()}    # Convertir la réponse JSON en dictionnaire
    Log                     ${ReponseJson}

    # Vérifier la structure de la réponse
    Dictionary Should Contain Key    ${ReponseJson}    data
    Dictionary Should Contain Key    ${ReponseJson}    support

    # Extraire les données de la ressource
    ${Resource}=            Get From Dictionary    ${ReponseJson}    data

    # Vérifier les champs obligatoires de la ressource
    Dictionary Should Contain Key    ${Resource}    id
    Dictionary Should Contain Key    ${Resource}    name
    Dictionary Should Contain Key    ${Resource}    year
    Dictionary Should Contain Key    ${Resource}    color
    Dictionary Should Contain Key    ${Resource}    pantone_value

    # Vérifier que l'ID correspond à celui demandé
    ${Resource_ID_Response}=    Get From Dictionary    ${Resource}    id
    Should Be Equal As Integers    ${Resource_ID}    ${Resource_ID_Response}

    # Vérifier que les données ne sont pas vides
    ${Name}=                Get From Dictionary    ${Resource}    name
    Should Not Be Empty     ${Name}
    ${Year}=                Get From Dictionary    ${Resource}    year
    Should Be True          ${Year} > 0
    ${Color}=               Get From Dictionary    ${Resource}    color
    Should Not Be Empty     ${Color}
    ${PantoneValue}=        Get From Dictionary    ${Resource}    pantone_value
    Should Not Be Empty     ${PantoneValue}
