*** Settings ***
Library     Selenium2Library
Resource    commun.resource

*** Test Cases ***
Le Tableau De Bord Doit Etre Visible Apres Une Connexion Réussie
    [Setup]    Effectuer Une Connection Réussie
    Vérifiez Que Le Tableau De Bord Est Visible
    [Teardown]    Effectuer Une Déconnexion Réussie

Le Lien De Connexion Devrait Etre Visible Après Une Déconnexion Réussie
    [Setup]    Effectuer Une Connection Réussie
    Vérifiez Que Le Tableau De Bord Est Visible
    Effectuer Une Déconnexion Réussie 
    Vérifier Que Le Lien De Connexion Est Visible


*** Keywords ***
Effectuer Une Connection Réussie
    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Accéder A La Page De Connexion
    Entrer Le Nom d'Utilisateur    ${UTILISATEUR VALIDE}
    Entrer Le Mot De Passe    ${MOT DE PASSE VALIDE}
    Soumettre Le Formulaire De Connexion
    
Vérifiez Que Le Tableau De Bord Est Visible
    # Attendre que le titre h1 soit visible pour confirmer la connexion
    Wait Until Element Is Visible    xpath=//h1[contains(text(),'Tableau de bord')]    timeout=15s
    Title Should Be    ${TITRE TABLEAU DE BORD}

Effectuer Une Déconnexion Réussie    
    # Vérifier la présence du lien de déconnexion avant de cliquer
    Wait Until Element Is Visible    ${LIEN SE DECONNECTER}    timeout=10s
    Click Link    ${LIEN SE DECONNECTER}
    
Vérifier Que Le Lien De Connexion Est Visible
    # Pause pour éviter l'erreur 'stale element reference' après le rafraîchissement
    Sleep    2s
    Wait Until Element Is Visible    ${LIEN SE CONNECTER}    timeout=15s
    Element Should Be Visible    ${LIEN SE CONNECTER}