### Introduction

Dans ce test, tu vas devoir **construire une UI qui affiche des données** provenant d'une (fake) API.

Pour t'aider, nous avons déjà créé le service `DestinationFetchingService` qui va retourner les données. Attention, cette API est un peu lente et ne marche pas toujours très bien ;)

**L'écran d'accueil correspond à la vue Destinations.**

Pour faire ce test, tu peux **forker ce repo** et faire l'implémentation de ton coté, tu nous enverras ensuite l'URL de ton repo.

Chez Evaneos, nous accordons beaucoup d'importance à la **qualité du code et à la qualité de l'expérience utilisateur** de nos produits. Dans ce test, notre but n'est pas tant de savoir si tu parviendras à construire ces écrans mais plutôt **la manière dont tu le feras**. N'hésite pas à faire attention aux détails, à être **rigoureux et prévoyant** sur l'expérience utilisateur (lenteur API, qualité UI) et sur **la propreté, la structure et la clarté du code**. N'hésite pas à nous solliciter si tu as des questions.

Nous souhaitons aussi que dans ce test tu nous montres ta capacité à **implémenter des tests unitaires**. Il n'y a pas besoin d'en faire pour tout, mais nous souhaitons en voir.

### Contraintes

- Comme nous utilisons essentiellement UIKit chez Evaneos, nous souhaitons que tu l'utilises également pour ce test (pas de SwiftUI). Aussi, nous n'utilisons pas de storyboards et évitons l'utilisation de xib pour faciliter la review de code. Essaie alors de ne pas en utiliser.
- L'app doit être codée en MVVM, et dans la mesure du possible en MVVM-C (notre app intègre ce pattern)

### Maquettes

[https://www.figma.com/file/4yIJXkSfo9xACHgG2KN0Yu/App-TestAlternantsMobileDestinationGuide?node-id=1%3A39](https://www.figma.com/file/4yIJXkSfo9xACHgG2KN0Yu/App-TestAlternantsMobileDestinationGuide?node-id=1%3A39)

### Vue Destinations

Cet écran va accueillir les destinations que le service retourne. 

L'affichage des destinations doit être par ordre alphabétique.

Lorsque l'utilisateur va sélectionner une destination, il faut push la vue Détails qui correspond à cette destination.

### Vue Détails

Cet écran n'affiche qu'une webview qui a pour URL celle fournie dans l'objet `DestinationDetails`

### Règles

- Limite les dépendances externes et justifie leur utilisation.
- Ne modifie pas le code de `DestinationFetchingService` (en tout cas celui-ci ne doit pas avoir été changé lors de la restitution)
- Essaie de faire des commits régulièrement (par exemple étape pour étape)

### Bonne chance !
