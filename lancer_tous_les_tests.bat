@echo off
echo Lancement de tous les tests...
call lancer_tests_unitaires.bat
call lancer_tests_api.bat
call lancer_tests_ihm.bat
pause