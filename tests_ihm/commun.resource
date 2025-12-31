*** Settings***
Library    Selenium2Library

*** Variables ***
# --- CONFIGURATION GLOBALE ---
${SERVEUR}         livraison3.testacademy.fr
${HOMEY URL}      http://${SERVEUR}/
${NAVIGATEUR}        Chrome

# --- VARIABLES DE CONNEXION (EXISTANTES) ---
${LIEN SE CONNECTER}    xpath=//a[contains(text(),'Se connecter')]
${LIEN SE DECONNECTER}    xpath=(//a[contains(text(),'Se déconnecter')])[3]
${UTILISATEUR VALIDE}     robot
${MOT DE PASSE VALIDE}    robot
${UTILISATEUR NON VALIDE}     nonvalide
${MOT DE PASSE NON VALIDE}    nonvalide
${CHAMP NOM UTILISATEUR}    name=username
${CHAMP MOT DE PASSE}    name=password
${BOUTON VALIDER}    css=.homey_login_button
${TITRE TABLEAU DE BORD}    Tableau de bord - Livraison 3
${ESPACE POUR AFFICHER LES ERREURS}    css=#modal-login .error

# --- VARIABLES CONTACTER HOTE (NOUVELLES) ---
# URL directe vers l'annonce présente dans les fichiers fournis (ID 271)
${URL ANNONCE}    http://${SERVEUR}/index.php/listing/affordable-urban-room/

# Bouton situé dans la sidebar (extrait de page_listing.html)
${BOUTON OUVRIR MODAL CONTACT}    xpath=//button[@data-target='#modal-contact-host']

# Locators du Modal (extrait de contact_form.html et NEZHA.side)
${MODAL CONTACT HOTE}       id=modal-contact-host
${CHAMP NOM CONTACT}        name=name
${CHAMP EMAIL CONTACT}      name=email
${CHAMP TELEPHONE CONTACT}  name=phone
${CHAMP MESSAGE CONTACT}    name=message
${BOUTON SOUMETTRE CONTACT}  css=.contact_listing_host

# Zone d'affichage des retours (succès/erreur) extraite de page_listing.html
${ZONE MESSAGE FEEDBACK}    css=.homey_contact_messages

# Données de test
${NOM TEST}       NEZHA
${EMAIL TEST}     nezhamansar7@gmail.com
${PHONE TEST}     0707099109
${MESSAGE TEST}   RÉSERVATION DE TEST


*** Keywords ***
# --- KEYWORDS GENERAUX ---
Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Open Browser    browser=${NAVIGATEUR}  
    Maximize Browser Window
    Go To     ${HOMEY URL}

# --- KEYWORDS CONNEXION ---
Accéder A La Page De Connexion
   Click Element    ${LIEN SE CONNECTER}
   Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}

Entrer Le Nom d'Utilisateur
    [Arguments]    ${nom_utilisateur}
   Click Element     ${CHAMP NOM UTILISATEUR}
   Input Text    ${CHAMP NOM UTILISATEUR}    ${nom_utilisateur}

Entrer Le Mot De Passe
    [Arguments]    ${mot_de_passe}
   Click Element     ${CHAMP MOT DE PASSE}
   Input Text    ${CHAMP MOT DE PASSE}    ${mot_de_passe}

Soumettre Le Formulaire De Connexion
   Click Button    ${BOUTON VALIDER}

# --- KEYWORDS CONTACT HOTE (NOUVEAUX) ---
Accéder A La Page De L'Annonce
    Go To    ${URL ANNONCE}
    Wait Until Element Is Visible    ${BOUTON OUVRIR MODAL CONTACT}

Ouvrir Le Formulaire De Contact
    Click Element    ${BOUTON OUVRIR MODAL CONTACT}
    Wait Until Element Is Visible    ${MODAL CONTACT HOTE}
    Wait Until Element Is Visible    ${CHAMP NOM CONTACT}

Remplir Le Formulaire De Contact
    [Arguments]    ${nom}    ${email}    ${tel}    ${msg}
    Input Text    ${CHAMP NOM CONTACT}        ${nom}
    Input Text    ${CHAMP EMAIL CONTACT}      ${email}
    Input Text    ${CHAMP TELEPHONE CONTACT}  ${tel}
    Input Text    ${CHAMP MESSAGE CONTACT}    ${msg}

Soumettre La Demande De Contact
    Click Element    ${BOUTON SOUMETTRE CONTACT}

Vérifier Que Le Feedback Est Visible
    # Vérifie que la div .homey_contact_messages n'est pas vide ou devient visible
    Wait Until Element Is Visible    ${ZONE MESSAGE FEEDBACK}