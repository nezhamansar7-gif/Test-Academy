*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary       # Import de la bibliothèque pour la manipulation JSON
Library    Collections       # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}     Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${User_ID}     1                                       # ID de l'utilisateur à récupérer

*** Test Cases ***
Test 002 Requete GET User By ID
    &{headers}=             Create Dictionary    Authorization=Bearer ${API_KEY}
    ${Reponse}=             GET    ${Base_URL}api/users/${User_ID}    headers=${headers}    expected_status=200
    ${ReponseJson}=         Set Variable    ${Reponse.json()}    # Convertir la réponse JSON en dictionnaire
    Log                     ${ReponseJson}

    # Vérifier la structure de la réponse
    Dictionary Should Contain Key    ${ReponseJson}    data
    Dictionary Should Contain Key    ${ReponseJson}    support

    # Extraire les données de l'utilisateur
    ${User}=                Get From Dictionary    ${ReponseJson}    data

    # Vérifier les champs obligatoires de l'utilisateur
    Dictionary Should Contain Key    ${User}    id
    Dictionary Should Contain Key    ${User}    email
    Dictionary Should Contain Key    ${User}    first_name
    Dictionary Should Contain Key    ${User}    last_name
    Dictionary Should Contain Key    ${User}    avatar

    # Vérifier que l'ID correspond à celui demandé
    ${User_ID_Response}=    Get From Dictionary    ${User}    id
    Should Be Equal As Integers    ${User_ID}    ${User_ID_Response}

    # Vérifier que les données ne sont pas vides
    ${Email}=               Get From Dictionary    ${User}    email
    Should Not Be Empty     ${Email}
    ${FirstName}=           Get From Dictionary    ${User}    first_name
    Should Not Be Empty     ${FirstName}
    ${LastName}=            Get From Dictionary    ${User}    last_name
    Should Not Be Empty     ${LastName}
