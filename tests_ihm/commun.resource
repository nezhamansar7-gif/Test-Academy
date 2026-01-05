*** Settings ***
Library    Selenium2Library

*** Variables ***
${URL}              https://test-academy.fr/  # Remplace par ton URL si différente
${BROWSER}          chrome
${NOM TEST}         Nezha Mansar
${EMAIL TEST}       nezha@test.com
${PHONE TEST}       0600000000
${MESSAGE TEST}     TEST AUTO JENKINS NEZHA

# Selecteurs (Locators) - À vérifier selon ton site
${BOUTON_ANNONCE}       xpath=//a[contains(text(),'Annonce')] 
${BOUTON_CONTACT}       id=contact-button
${CHAMP_NOM}            id=name
${CHAMP_EMAIL}          id=email
${CHAMP_PHONE}          id=phone
${CHAMP_MESSAGE}        id=message
${BOUTON_SOUMETTRE}     id=submit-button
${ZONE_FEEDBACK}        id=feedback-message

*** Keywords ***
Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # On attend que la page soit bien chargée
    Wait Until Page Contains Element    ${BOUTON_ANNONCE}    timeout=15s

Accéder A La Page De L'Annonce
    Wait Until Element Is Visible    ${BOUTON_ANNONCE}    timeout=10s
    Click Element    ${BOUTON_ANNONCE}

Ouvrir Le Formulaire De Contact
    Wait Until Element Is Visible    ${BOUTON_CONTACT}    timeout=10s
    Click Element    ${BOUTON_CONTACT}

Remplir Le Formulaire De Contact
    [Arguments]    ${nom}    ${email}    ${phone}    ${msg}
    Wait Until Element Is Visible    ${CHAMP_NOM}    timeout=10s
    Input Text      ${CHAMP_NOM}       ${nom}
    Input Text      ${CHAMP_EMAIL}     ${email}
    Input Text      ${CHAMP_PHONE}     ${phone}
    Input Text      ${CHAMP_MESSAGE}   ${msg}

Soumettre La Demande De Contact
    # On s'assure que le bouton est cliquable avant de cliquer
    Wait Until Element Is Visible    ${BOUTON_SOUMETTRE}    timeout=10s
    Click Element    ${BOUTON_SOUMETTRE}
    # Petit temps de pause pour laisser le serveur répondre
    Sleep    2s

Vérifier Que Le Feedback Est Visible
    # C'est ici que Jenkins échouait souvent par manque de patience
    Wait Until Element Is Visible    ${ZONE_FEEDBACK}    timeout=15s
    Element Should Be Visible       ${ZONE_FEEDBACK}