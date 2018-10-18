# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
  - User has_many Sales.
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
  - Sale belongs_to User.
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
  - User has_many Products through Sales.
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
  - Sales have a product_id and a quantity.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  - See validations on models.
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  - list_hot_products Product class method with URL: /hot_products (only for managers).
- [x] Include signup (how e.g. Devise)
  - Signup is on the welcome page.
- [x] Include login (how e.g. Devise)
  - Login by email or through Facebook.
- [x] Include logout (how e.g. Devise)
  - Logout link is present when a user is logged in.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  - Facebook
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  - Users have Product and Sale nested resources.
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
  - Fields with errors highlight red.

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
