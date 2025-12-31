*** Settings***
Library    Selenium2Library
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
    Wait Until Element Is Not Visible    ${CHAMP NOM UTILISATEUR}
    Title Should Be    ${TITRE TABLEAU DE BORD}

Effectuer Une Déconnexion Réussie    
    Click Link    ${LIEN SE DECONNECTER}
    
Vérifier Que Le Lien De Connexion Est Visible
    Wait Until Element Is Not Visible    ${LIEN SE DECONNECTER}
    Element Should Be Visible    ${LIEN SE CONNECTER}