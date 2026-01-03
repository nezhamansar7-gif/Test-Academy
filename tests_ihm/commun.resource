*** Settings ***
Library    Selenium2Library

*** Variables ***
# --- CONFIGURATION GLOBALE ---
${SERVEUR}                   livraison3.testacademy.fr
${HOMEY URL}                 http://${SERVEUR}/
${NAVIGATEUR}                Chrome

# --- VARIABLES DE CONNEXION ---
${LIEN SE CONNECTER}         xpath=//a[contains(normalize-space(text()), 'Se connecter')]
${LIEN SE DECONNECTER}       xpath=(//a[contains(text(),'Se déconnecter')])[3]
${UTILISATEUR VALIDE}        robot
${MOT DE PASSE VALIDE}       robot
${CHAMP NOM UTILISATEUR}     name=username
${CHAMP MOT DE PASSE}        name=password
${BOUTON VALIDER}            css=.homey_login_button
${TITRE TABLEAU DE BORD}     Tableau de bord - Livraison 3

# --- VARIABLES CONTACT HOTE ---
${URL ANNONCE}               http://${SERVEUR}/index.php/listing/affordable-urban-room/
${BOUTON OUVRIR MODAL CONTACT}    xpath=//button[@data-target='#modal-contact-host']
${MODAL CONTACT HOTE}        id=modal-contact-host
${CHAMP NOM CONTACT}         name=name
${CHAMP EMAIL CONTACT}       name=email
${CHAMP TELEPHONE CONTACT}   name=phone
${CHAMP MESSAGE CONTACT}     name=message
${BOUTON SOUMETTRE CONTACT}  css=.contact_listing_host
${ZONE MESSAGE FEEDBACK}     css=.homey_contact_messages

*** Keywords ***
# --- KEYWORDS GENERAUX ---
Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Open Browser    browser=${NAVIGATEUR}
    Maximize Browser Window
    Go To    ${HOMEY URL}

# --- KEYWORDS CONNEXION ---
Accéder A La Page De Connexion
    Wait Until Element Is Visible    ${LIEN SE CONNECTER}    timeout=15s
    Click Element    ${LIEN SE CONNECTER}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}    timeout=10s

Entrer Le Nom d'Utilisateur
    [Arguments]    ${nom_utilisateur}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}    timeout=5s
    Input Text    ${CHAMP NOM UTILISATEUR}    ${nom_utilisateur}

Entrer Le Mot De Passe
    [Arguments]    ${mot_de_passe}
    Input Text    ${CHAMP MOT DE PASSE}    ${mot_de_passe}

Soumettre Le Formulaire De Connexion
    Click Button    ${BOUTON VALIDER}

# --- KEYWORDS CONTACT HOTE ---
Accéder A La Page De L'Annonce
    Go To    ${URL ANNONCE}
    Wait Until Element Is Visible    ${BOUTON OUVRIR MODAL CONTACT}    timeout=15s

Ouvrir Le Formulaire De Contact
    Click Element    ${BOUTON OUVRIR MODAL CONTACT}
    Wait Until Element Is Visible    ${MODAL CONTACT HOTE}    timeout=10s

Remplir Le Formulaire De Contact
    [Arguments]    ${nom}    ${email}    ${tel}    ${msg}
    Input Text    ${CHAMP NOM CONTACT}         ${nom}
    Input Text    ${CHAMP EMAIL CONTACT}        ${email}
    Input Text    ${CHAMP TELEPHONE CONTACT}    ${tel}
    Input Text    ${CHAMP MESSAGE CONTACT}      ${msg}

Soumettre La Demande De Contact
    Click Element    ${BOUTON SOUMETTRE CONTACT}

Vérifier Que Le Feedback Est Visible
    Wait Until Element Is Visible    ${ZONE MESSAGE FEEDBACK}    timeout=10s