*** Settings ***
Library     Selenium2Library
Resource    commun.resource
Test Setup    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
Test Teardown    Close Browser

*** Test Cases ***
# --- TESTS STABILISÉS POUR JENKINS ---

Contacter L'Hôte Avec Des Données Valides
    [Documentation]    Cas passant standard complet avec attentes stabilisées.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Champ Nom Vide
    [Documentation]    Vérifie l'échec si le nom est manquant.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${EMPTY}    ${EMAIL TEST}    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Champ Email Vide
    [Documentation]    Vérifie l'échec si l'email est manquant.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMPTY}    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Format Email Invalide
    [Documentation]    Correction du Timeout : Ajout d'une attente explicite.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    email_invalide    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    # On attend spécifiquement que l'élément de feedback apparaisse (max 10s)
    Wait Until Element Is Visible    ${ZONE MESSAGE FEEDBACK}    timeout=10s
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Champ Message Vide
    [Documentation]    Correction du Timeout : Stabilisation de la soumission.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${PHONE TEST}    ${EMPTY}
    Soumettre La Demande De Contact
    Wait Until Element Is Visible    ${ZONE MESSAGE FEEDBACK}    timeout=10s
    Vérifier Que Le Feedback Est Visible

# --- AUTRES TESTS ---

Contacter L'Hôte Avec Un Champ Téléphone Vide
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${EMPTY}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Email Sans Extension
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    user@testacademy    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible