*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary       # Import de la bibliothèque pour la manipulation JSON
Library    Collections       # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}     Cle-API-ReqRes-test-academy            # Clé API pour l'authentification

*** Test Cases ***
Test 003 Requete GET Resources
    &{Params}=              Create Dictionary    page=1    per_page=6    # Créer un dictionnaire de paramètres pour la requête
    &{headers}=             Create Dictionary    Authorization=Bearer ${API_KEY}
    ${Reponse}=             GET    ${Base_URL}api/unknown    params=${Params}    headers=${headers}    expected_status=200
    ${ReponseJson}=         Set Variable    ${Reponse.json()}    # Convertir la réponse JSON en dictionnaire
    Log                     ${ReponseJson}

    # Vérifier la structure de pagination
    Dictionary Should Contain Key    ${ReponseJson}    page
    Dictionary Should Contain Key    ${ReponseJson}    per_page
    Dictionary Should Contain Key    ${ReponseJson}    total
    Dictionary Should Contain Key    ${ReponseJson}    total_pages
    Dictionary Should Contain Key    ${ReponseJson}    data
    Dictionary Should Contain Key    ${ReponseJson}    support

    # Vérifier les valeurs de pagination
    ${Page}=                Get From Dictionary    ${ReponseJson}    page
    Should Be Equal As Integers    ${Page}    1
    ${PerPage}=             Get From Dictionary    ${ReponseJson}    per_page
    Should Be Equal As Integers    ${PerPage}    6

    # Extraire la liste des ressources
    ${ListeRessources}=     Get Value From Json    ${ReponseJson}    data[:]    # Extraire la liste des ressources du dictionnaire JSON
    ${NombreRessources}=    Get Length    ${ListeRessources}
    Should Be True          ${NombreRessources} > 0    # Vérifier qu'il y a au moins une ressource

    # Vérifier la structure de la première ressource
    ${PremiereRessource}=   Get From List    ${ListeRessources}    0
    Dictionary Should Contain Key    ${PremiereRessource}    id
    Dictionary Should Contain Key    ${PremiereRessource}    name
    Dictionary Should Contain Key    ${PremiereRessource}    year
    Dictionary Should Contain Key    ${PremiereRessource}    color
    Dictionary Should Contain Key    ${PremiereRessource}    pantone_value

    # Vérifier que les données ne sont pas vides
    ${Name}=                Get From Dictionary    ${PremiereRessource}    name
    Should Not Be Empty     ${Name}
    ${Color}=               Get From Dictionary    ${PremiereRessource}    color
    Should Not Be Empty     ${Color}
