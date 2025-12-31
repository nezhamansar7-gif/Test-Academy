*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    Collections

*** Variables ***
${Base_URL}         https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}          Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${Id_Utilisateur}   8

*** Test Cases ***
Test Requete DELETE
    &{headers}=    Create Dictionary    Authorization=Bearer ${API_KEY}
    &{Corps_Requete}=   Create Dictionary    first_name=Temp    last_name=User    email=temp.user@reqres.in
    ${Reponse_Creation}=    POST    ${Base_URL}api/users    json=${Corps_Requete}    headers=${headers}    expected_status=201
    ${Id_Cree}=    Get From Dictionary    ${Reponse_Creation.json()}    id
    ${Reponse}=    DELETE    ${Base_URL}api/users/${Id_Cree}    headers=${headers}    expected_status=204