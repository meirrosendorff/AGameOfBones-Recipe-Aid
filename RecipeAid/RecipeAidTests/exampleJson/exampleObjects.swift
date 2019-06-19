//
//  exampleSearchResultRecipeSet.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
@testable import RecipeAid

let soupSearchRecipeSet = [Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_b373d8987afb5808439ff243c16ccb63", label: "Grandma chicken soup (Canja)", image: "https://www.edamam.com/web-img/bab/bab4ee2d4ce0e0bbb626f098069ee98e.JPG", source: "Food52", url: "https://food52.com/recipes/2486-grandma-chicken-soup-canja", yield: 2.0, ingredientLines: ["2 1/2 cups of water", "1 chicken breast", "1/2 cup soup shape pasta (we use barilla orzo or pastina; or short-grain white rice, if you cannot find the soup pasta)", "1 teaspoon of sea salt", "1 1/2 tablespoon of extra virgin olive oil", "Cilantro for garnish"], calories: 829.29),
              Recipe( uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_bfd7fb28f8d2ff1f3057ff82975c9ae2", label: "Matzo Ball Soup", image: "https://www.edamam.com/web-img/629/629e838385785eab3ee40bf91743e64b.jpg", source: "Martha Stewart", url: "http://www.marthastewart.com/969413/matzo-ball-soup", yield: 4.0, ingredientLines: ["Homemade chicken broth for matzo ball soup, chilled", "4 large eggs, separated", "Salt and pepper", "1/4 cup seltzer", "1 cup matzo meal", "4 carrots, sliced", "Dill sprigs, for serving"], calories: 647.683646),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_697f97298fa57124c35067fac86d57d3", label: "Cleansing Ginger-Chicken Soup", image: "https://www.edamam.com/web-img/f5d/f5dc27fa2ad8cbff1f5aa6a60aabb1b8.jpg", source: "Bon Appetit", url: "http://www.bonappetit.com/recipes/2012/01/cleansing-ginger-chicken-soup", yield: 8.0, ingredientLines: ["1 onion, sliced", "2 celery stalks, chopped", "8 ounces unpeeled scrubbed ginger, cut into 1/2\"-thick slices Read More http://www.bonappetit.com/recipes/2012/01/cleansing-ginger-chicken-soup#ixzz1wL2JvTkt", "2 garlic cloves, crushed", "10 whole black peppercorns", "Kosher salt", "Cilantro leaves (optional)"], calories: 260.706948),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_585c8f3bacd3abb464430ebac7e15a41", label: "French In A Flash: French Onion Soup Dumplings", image: "https://www.edamam.com/web-img/8c8/8c84d530252770fdfc0e3c87d3eb22fa.jpg", source: "Serious Eats", url: "http://www.seriouseats.com/recipes/2009/03/french-in-a-flash-french-onion-soup-dumplings-recipe.html", yield: 12.0, ingredientLines: ["Counterfeit French Onion Soup Onions (recipe below), or 1 to 1 1/2 cups reserved onions from French Onion Soup", "15 to 20 wonton wrappers", "1 cup Gruyère, grated", "1/3 cup Parmesan, grated", "Chives, or twigs of thyme, for garnish", "A pat of butter", "Counterfeit French Onion Soup Onions", "1 tablespoon butter", "1 tablespoon olive oil", "2 red onions, thinly sliced", "1 sweet yellow onion, thinly sliced", "1/2 tablespoon sugar", "Salt and pepper", "1/4 cup cognac", "1/2 cup dry white wine", "1 cup beef stock", "1 bay leaf", "The leaves of 4 sprigs thyme"], calories: 3121.547919333333),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_d90b96b45a6361ad1d712e9d66591b88", label: "Tortilla Soup", image: "https://www.edamam.com/web-img/74b/74b3b6a81884a750891584948e3203d5.jpg", source: "Real Simple", url: "http://www.realsimple.com/food-recipes/browse-all-recipes/tortilla-soup", yield: 4.0, ingredientLines: ["2 14- to 19-oz cans chicken noodle soup", "1 cup frozen corn kernels", "1 tsp hot sauce", "2 cups tortilla chips", "1 avocado, cut into pieces"], calories: 1337.11056578125),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_b97ffd07bd98e72e5232ea67786c2696", label: "Cheats Chicken And Bean Soup", image: "https://www.edamam.com/web-img/a9f/a9f0b14d4de248c0fd45cc539b632245.jpg", source: "BBC Good Food", url: "http://www.bbcgoodfood.com/recipes/8380/cheats-chicken-and-bean-soup", yield: 2.0, ingredientLines: ["1 400g tin x cream of chicken soup", "Large pinch of ground cinnamon", "1/2 tsp sumac", "Large pinch of mild chili powder", "2-4 tbsp lemon juice (according to taste)", "Half a tin of borlotti beans"], calories: 485.2037187513897),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_ffd04917b62e3eee9064b47bf7279ebe", label: "Chicken Casserole with Campbell\'s Canned Soup recipes", image: "https://www.edamam.com/web-img/5c0/5c06e40fd2560bd72ea99e49acef8741", source: "Tasting Table", url: "https://www.tastingtable.com/cook/recipes/chicken-casserole-recipe-campbells-cream-of-mushroom-soup?utm_medium=yummly&utm_source=yummly&utm_campaign=yummly", yield: 6.0, ingredientLines: ["4 boneless, skinless chicken breasts", "1 package egg noodles", "One 10¾-ounce can cream of mushroom soup", "One 10¾-ounce can cream of chicken soup", "One 8-ounce container sour cream", "kosher salt", "freshly ground black pepper", "4 slices white bread", "1 stick unsalted butter, plus more for greasing"], calories: 4574.663132833433),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_25dc45a7efe00150e79b232b4ef6060c", label: "Homemade Chicken Noodle Soup", image: "https://www.edamam.com/web-img/50e/50e6b589f122ef2f3f6125d2bdfda981.jpg", source: "Simply Recipes", url: "http://www.simplyrecipes.com/recipes/chicken_noodle_soup/", yield: 26.0, ingredientLines: ["One 3 1/2-pound chicken, cut into parts—breast, thighs, backs, wings and neck (if available)", "5 carrots (2 carrots scrubbed clean, but not peeled, cut into 2 inch chunks for the stock, 3 carrots peeled and cut into 1/4-inch rounds for the soup)", "5 ribs of celery (2 ribs cut into 2 inch pieces for the stock, 3 ribs cut into 1/4-inch thick slices for the soup), including celery tops for the stock", "1 onion, quartered (for stock, peel on is okay)", "3 cloves of garlic, peel on, cut in half", "2 to 3 sprigs of fresh thyme (or a teaspoon of dried)", "1 bunch of parsley", "5 whole peppercorns", "Salt", "8 to 12 ounces of  egg noodles (depending on how noodle-y you want your soup)", "Freshly ground black pepper"], calories: 3682.4742312926624),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_4ccd70268c8e2cc2724a990ad9ac1b8e", label: "Matzo Ball Soup", image: "https://www.edamam.com/web-img/69c/69c6c277a67a73fb680aa35fc24140d6.jpg", source: "Epicurious", url: "https://www.epicurious.com/recipes/food/views/matzo-ball-soup", yield: 6.0, ingredientLines: ["1/2 large chicken (about 2 1/2 pounds), cut into pieces or a combination of necks, backs, wings, and other chicken parts to equal 4 pounds", "4 stalks celery, tops included, roughly chopped", "3 to 4 carrots, roughly chopped", "2 yellow onions, roughly chopped", "1 small parsnip, roughly chopped", "1 small turnip, peeled and chopped", "1 tablespoon Kosher salt", "1 teaspoon whole black peppercorns", "1 point of a star anise", "4 sprigs fresh dill", "5 large eggs", "4 tablespoons hot chicken soup or water", "3 tablespoons chicken fat (schmaltz), skimmed from the soup", "1 teaspoon Kosher salt plus more for cooking water", "1 cup plus 2 tablespoons matzo meal"], calories: 2956.3143623491756),
Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_f677ae0ad146c5a6bf5b60c3791b39b6", label: "Chicken Noodle Soup", image: "https://www.edamam.com/web-img/d56/d5673cfddf4e0c46c420f8c043fc2279.jpg", source: "Good Housekeeping", url: "http://www.goodhousekeeping.com/food-recipes/a5499/chicken-noodle-soup-2338/", yield: 2.0, ingredientLines: ["Basic Chicken Soup", "2 c. medium egg noodles", "1 c. frozen peas", "Grated Parmesan cheese (optional)"], calories: 410.14000000000004)
]

let iceCreamRecipe = Recipe(
  uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_dc0bd9f18c68a5710d0fc3fda6512b7b",
  label: "Mont Blanc Ice-Cream Squares",
  image: "https://www.edamam.com/web-img/266/2661363453d5be1fba4af484b956829c.jpg",
  source: "BBC Good Food",
  url: "http://www.bbcgoodfood.com/recipes/8235/",
  yield: 14.0,
  ingredientLines: [ "FOR THE PURÉE",
                     "4 egg whites",
                     "50.0ml double cream",
                     "2 x 1-litre tubs good-quality vanilla icecream (we used Waitrose Seriously Creamy)",
                     "Ingredients FOR THE MERINGUE",
                     "50.0g walnuts",
                     "5 marrons glaces or candied chestnuts , halved",
                     "FOR THE ICE CREAM", "250.0g golden caster sugar",
                     "435.0g can chestnut purée (we used Merchant Gourmet)" ],
  calories: 7586.821023526832)

let dummyRecipe = Recipe(
  uri: "uri",
  label: "name",
  image: "imageUrl",
  source: "source",
  url: "sourceURL",
  yield: 42.01,
  ingredientLines: [ "Ingredient 0", "Ingredient 1", "Ingredient 2", "Ingredient 3", "Ingredient 4", "Ingredient 5", "Ingredient 6", "Ingredient 7", "Ingredient 8", "Ingredient 9" ],
  calories: 42.01)
