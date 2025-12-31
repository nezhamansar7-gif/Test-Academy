*** Settings ***
Library    Selenium2Library
Resource    commun.resource
Test Setup    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
Test Template    Un Message d'Erreur Doit Etre Visible Apres Une Connexion Incorrecte

*** Test Cases ***
# cas de test                                     # nom utilisateur    # mot de passe
Test Utilisateur Valide Mot De Passe Vide        robot              ${EMPTY}        
Test Utilisateur Vide Mot De Passe Valide        ${EMPTY}           robot
Test Utilisateur Vide Mot De Passe Vide          ${EMPTY}           ${EMPTY} 
Test Utilisateur Non Valide Mot De Passe Valide  azerty             robot
Test Utilisateur Valide Mot De Passe Non Valide  robot              azerty
Test Utilisateur Non Valide Mot De Passe Non Valide  azerty         azerty        

*** Keywords ***
Vérifier Que Le Message d'Erreur Est Visible
    Wait Until Element Is Visible    ${ESPACE POUR AFFICHER LES ERREURS}
    Element Text Should Not Be        ${ESPACE POUR AFFICHER LES ERREURS}    ${EMPTY}

Un Message d'Erreur Doit Etre Visible Apres Une Connexion Incorrecte
    [Arguments]    ${nom_utilisateur}    ${mot_de_passe}
    Accéder A La Page De Connexion
    Entrer Le Nom d'Utilisateur    ${nom_utilisateur}
    Entrer Le Mot De Passe          ${mot_de_passe}
    Soumettre Le Formulaire De Connexion
    Vérifier Que Le Message d'Erreur Est Visible
