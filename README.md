# Reciplease
OCR Project Recipes

iOS : 13.0
Compatibility :  toutes les tailles d’iPhone (hors 4S)
Orientation device : portrait
Version : 1.0
Bookstore Manager : CocoaPods
Bookstores : Alamofire, AlamofireImage, CoreData

Reciplease 

LOGO APPLICATION

L'application Reciplease permet de saisir des ingrédients dans le champs texte. 
La liste des ingrédients sélectionnées est envoyé à l'API Edaman grâce à la librairie Alamofire. 
L'API Edaman renvoi en retour une liste de recettes possible avec les ingrédients saisit.
en cliquant sur une des recettes, une vue s'affiche avec : 
● Le titre de la recette
● La liste complète des ingrédients avec le détail des portions
● L'image, si elle est présente (mettre une image par défaut sinon)
● La durée d'exécution de la recette, si présente
● Le nombre de couvert, si est présente
● Un bouton pour accéder à la liste détaillée des instructions grâce au site internet où elle est publiée.

Une étoile est présente en haut à droite de l'écran, en la sélectionnant, la recette est ajoutée en favoris grâce à CoreData.
