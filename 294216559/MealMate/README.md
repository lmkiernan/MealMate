# *MealMate*

## Description

##Fridge Capabilities

The current working version of the MealMate app allows you to keep track of your fridge's contents, and manage them (adding and subtracting them) based on any changed you would like to make. This takes place in within the MyFridgeView  screen, which allows you to add items (by clicking the + icon). When we go to add items, we add them as an ingredient. This accesses the ingredient entity in our MealMate data model, which is saved within our Core Data. We did this so that we could have persistent storage and still be adhering to the MVVM archetype. Upon adding things as ingredients using the AddEditIngredientView screen, they will immediately show up in our fridge using the MyFridgeView and the  IngredientRowView. The addition of the groceries in the AddEditIngredientView uses an API that accesses the USDA database of food, as well as describe the quantity, and the expiration date. 

##Grocery List Capabilities
The grocery list can be toggled to through the cart icon at the bottom of the screen. Upon reaching your grocery list section, you can add items to your grocery list using the "+" icon in the top right corner, searching from the USDA  database (connected using an API) and then adjusting the quantity and expiration dates to your needs. You can remove the groceries using the edit button at the top left corner of your screen and deleting things from the list. This grocery list accesses the grocery entity of the MealMate model that is a part of the CoreData (to ensure persistent storage). Within our grocery list we have it so that when you "cross off a grocery" (by pressing the circle to the left of the item) that grocery is converted to an ingredient and shows up in your fridge. If the ingredient already exists in the fridge, it increments the quantity by how much was in the grocery list for that given item. 

##Use of Network Requests
We used the fdc USDA API (https://fdc.nal.usda.gov/api-guide#bkmk-6) as a database of all of the food that people would want to access as a grocery or an ingredient. We have this coded into the AddEditIngredientView and the AddEditGroceryView

##Use of Persistent Storage
We used Persistent Storage through our handling of the MealMate model which includes the grocery and the ingredients entities this allowed us to have a fridge that is unique to that user and is persistently stored over time, as well as have a grocery list that can become personalized and can be edited and stored over time.
