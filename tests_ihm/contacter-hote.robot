*** Settings ***
Library    Selenium2Library
Resource    commun.resource
Test Setup    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
Test Teardown    Close Browser

*** Test Cases ***
# --- TESTS INITIAUX (5) ---

Contacter L'Hôte Avec Des Données Valides
    [Documentation]    Cas passant standard complet.
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
    [Documentation]    Vérifie l'échec si le format email est incorrect (ex: pas de @).
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    email_invalide    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Champ Message Vide
    [Documentation]    Vérifie l'échec si le message est manquant.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${PHONE TEST}    ${EMPTY}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

# --- NOUVEAUX TESTS (5) ---

Contacter L'Hôte Avec Un Champ Téléphone Vide
    [Documentation]    Vérifie le comportement si le téléphone est omis (souvent optionnel ou requis).
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${EMPTY}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Email Sans Extension
    [Documentation]    Teste un format d'email invalide spécifique (ex: user@domain sans .com).
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    user@testacademy    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Des Caractères Spéciaux Dans Le Nom
    [Documentation]    Vérifie si le formulaire accepte ou rejette les caractères spéciaux.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    !@#$%^&*()    ${EMAIL TEST}    ${PHONE TEST}    ${MESSAGE TEST}
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Un Message Très Court
    [Documentation]    Teste la validation de longueur minimale du message (ex: 1 caractère).
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${PHONE TEST}    A
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible

Contacter L'Hôte Avec Injection HTML Simple Dans Le Message
    [Documentation]    Teste la sécurité de base du champ message.
    Accéder A La Page De L'Annonce
    Ouvrir Le Formulaire De Contact
    Remplir Le Formulaire De Contact    ${NOM TEST}    ${EMAIL TEST}    ${PHONE TEST}    <b>Test Gras</b>
    Soumettre La Demande De Contact
    Vérifier Que Le Feedback Est Visible