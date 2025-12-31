# Script Python pour exécuter une requête GET en environnement local
# Remarque : Si vous utilisez cet environnement dans un navigateur ou en ligne, les requêtes vers des API externes peuvent échouer à cause de restrictions CORS ou de la connexion Internet.

import requests

url = 'https://reqres.in/api/users/2'

try:
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    data = response.json()
    print('Données reçues :', data)
except requests.exceptions.RequestException as e:
    print("Impossible de se connecter à l'API. Assurez-vous que vous exécutez ce script dans un environnement Python avec accès Internet et hors d'un navigateur.")