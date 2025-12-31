*** Settings ***
Library               RequestsLibrary

*** Test Cases ***
Test Requête Get Simple
    ${reponse}=    GET    https://www.google.com