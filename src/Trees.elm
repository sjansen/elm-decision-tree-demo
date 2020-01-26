module Trees exposing (recipes)

import DecisionTree exposing (Decision, DecisionTree(..))
import Dict exposing (Dict)


recipes : DecisionTree
recipes =
    Parent
        { label = "Which meal are you planning?"
        , alternatives =
            Dict.fromList
                [ ( "breakfast"
                  , { label = "Breakfast"
                    , tree = breakfast
                    }
                  )
                , ( "lunch"
                  , { label = "Lunch"
                    , tree = lunch
                    }
                  )
                , ( "supper"
                  , { label = "Supper"
                    , tree = supper
                    }
                  )
                ]
        }


pending : DecisionTree
pending =
    Leaf
        { label = "Content Pending"
        , detail = Nothing
        }


breakfast : DecisionTree
breakfast =
    Parent
        { label = "What are you in the mood for?"
        , alternatives =
            Dict.fromList
                [ ( "bread"
                  , { label = "Bread"
                    , tree = muffins
                    }
                  )
                , ( "eggs"
                  , { label = "Eggs"
                    , tree =
                        Parent
                            { label = "How hungry are you?"
                            , alternatives =
                                Dict.fromList
                                    [ ( "normal"
                                      , { label = "Average"
                                        , tree = omelet
                                        }
                                      )
                                    , ( "very"
                                      , { label = "Very hungry"
                                        , tree = fullEnglish
                                        }
                                      )
                                    ]
                            }
                    }
                  )
                , ( "sausage"
                  , { label = "Sausage"
                    , tree =
                        Parent
                            { label = "How hungry are you?"
                            , alternatives =
                                Dict.fromList
                                    [ ( "normal"
                                      , { label = "Average"
                                        , tree = quiche
                                        }
                                      )
                                    , ( "very"
                                      , { label = "Very hungry"
                                        , tree = fullEnglish
                                        }
                                      )
                                    ]
                            }
                    }
                  )
                ]
        }


lunch : DecisionTree
lunch =
    Parent
        { label = "What are you in the mood for?"
        , alternatives =
            Dict.fromList
                [ ( "salad"
                  , { label = "Salad"
                    , tree = salad
                    }
                  )
                , ( "soup"
                  , { label = "Soup"
                    , tree = soup
                    }
                  )
                ]
        }


supper : DecisionTree
supper =
    Parent
        { label = "What are you in the mood for?"
        , alternatives =
            Dict.fromList
                [ ( "beef"
                  , { label = "Beef"
                    , tree = stroganoff
                    }
                  )
                , ( "chicken"
                  , { label = "Chicken"
                    , tree = satay
                    }
                  )
                , ( "seafood"
                  , { label = "Seafood"
                    , tree = paella
                    }
                  )
                ]
        }


fullEnglish : DecisionTree
fullEnglish =
    Leaf
        { label = "Full English Breakfast"
        , detail = Just """
## Ingredients

- 2 eggs
- 3 slices Canadian bacon
- 2 sausage links, brown and serve
- 1 roma tomato, halved lengthwise
- 2 ounces fresh mushrooms, quartered
- 1 tablespoon butter
- 1 small tin sugar free baked beans
- salt and pepper, to taste

## Directions

1. Heat the baked beans in a saucepan.
1. Heat the butter in a large skillet.
1. Saute the mushrooms on medium-high heat until tender, season to taste with salt and pepper.
1. Remove from pan and keep warm.
1. In same skillet, place the tomatoes, bacon and sausage links.
1. Cook until heated through and browned.
1. Turn to cook both sides of tomato and meats.
1. Sprinkle tomatoes with salt and pepper.
1. Meanwhile, fry or scramble eggs in the remaining butter in a small skillet.
1. Arrange all on dinner plate and eat.

https://recipes.fandom.com/wiki/Full_English_Breakfast
"""
        }


muffins : DecisionTree
muffins =
    Leaf
        { label = "Banana Oat Muffins"
        , detail = Just """
## Ingredients

- 2 cups oat circles (such as Cheerios, crushed)
- 1 ¼ cups flour
- ⅓ cup packed brown sugar
- 1 teaspoon baking powder
- ¾ teaspoon baking soda
- 1 cup mashed very ripe bananas (2 – 3 medium)
- ⅔ cup lowfat milk
- 3 tablespoons oil
- 1 egg

## Directions

1. Heat oven to 400°F.
1. Spray 12 regular-sized muffin cups with cooking spray, or grease bottoms only of muffin cups.
1. Mix cereal, flour, brown sugar, baking powder, and baking soda in a large bowl.
1. Add bananas, milk, oil, and egg.
1. Stir just until moistened.
1. Divide batter among twelve muffin cups.
1. Bake 18 – 22 minutes until golden brown.

https://recipes.fandom.com/wiki/Banana_Oat_Muffins
"""
        }


omelet : DecisionTree
omelet =
    Leaf
        { label = "Cheese Omelet"
        , detail = Just """
## Ingredients

- 4 eggs separated
- 4 tbsp. hot water
- 1 tsp. salt
- 1 tsp. ground black pepper
- 3 tbsp. breadcrumbs
- 2 cups grated cheese
- 2 tbsp. butter

## Directions

1. Beat the egg yolks thoroughly and add to them the hot water, salt, crumbs, and cheese.
1. Beat the egg whites until stiff, but not dry, and fold them carefully into the yolk mixture.
1. Heat the butter in a frying pan.
1. Pour in the mixture, brown very slowly over the heat, and then place in the oven to cook the top. Serve at once.

https://recipes.fandom.com/wiki/Cheese_Omelet
"""
        }


paella : DecisionTree
paella =
    Leaf
        { label = "Half-hour Paella"
        , detail = Just """
## Ingredients

- ½ cup chopped onion
- ½ cup chopped celery
- 1 tablespoon butter or margarine
- 1 cup uncooked rice
- ¼ teaspoon salt
- ¼ teaspoon saffron
- chicken broth
- 1 x 8-ounce can minced clams (drain; reserve liquid)
- 1½ cups boned cooked chicken pieces (leave in large pieces)
- 1 cup cooked peeled and deveined shrimp
- ½ cup cooked green peas
- quartered fresh tomatoes for garnish (optional)

## Directions

1. Cook onion and celery in butter in large skillet over medium heat until tender but not brown.
1. Add rice, salt, saffron and enough chicken broth to clam liquid to make 2 cups.
1. Bring to a boil.
1. Stir, reduce heat, cover, and simmer 15 minutes or until rice is tender and liquid is absorbed.
1. Stir in clams, chicken, shrimp and peas.
1. Cook 5 minutes longer.
1. Serve garnished with tomatoes, if desired.

https://recipes.fandom.com/wiki/Half-hour_Paella
"""
        }


salad : DecisionTree
salad =
    Leaf
        { label = "Gulf Coast Salad"
        , detail = Just """
## Ingredients

- 3 cups cooked rice (cooked in chicken broth)
- 1 pound cooked, peeled deveined Shrimp*
- 1 cup sliced celery
- ½ cup sliced green onions
- ½ cup Mayonnaise
- 2 tablespoons catsup
- 1 teaspoon lemon juice
- ½ teaspoon cream-style prepared horseradish
- ½ teaspoon prepared mustard
- ⅛ teaspoon hot pepper sauce
- salt and ground white or black pepper (optional)
- salad greens (optional)
- lemon wedges and parsley for garnish (optional)

## Directions

1. Combine rice, Shrimp, celery and green onions in large mixing bowl.
1. Blend Mayonnaise, catsup, lemon juice, horseradish, mustard and pepper sauce. Add to rice mixture.
1. Toss lightly and season to taste with salt and pepper.
1. Chill.
1. Serve on salad greens and garnish with lemon wedges and parsley, if desired.

https://recipes.fandom.com/wiki/Gulf_Coast_Salad
"""
        }


satay : DecisionTree
satay =
    Leaf
        { label = "Lemongrass Chicken Satay"
        , detail = Just """
## Ingredients

- 500 g. chicken thighs
- 3 spring onions
- 3 red chilies
- 3 cloves garlic
- 2 large eggs
- 2 limes, juiced
- 2 tablespoons fish sauce
- 1 tablespoon cornflour
- 1 tablespoon black pepper
- 1 teaspoon sugar, white only
- 10 stalks lemongrass, about 12 cm long
- 2 tablespoons canola oil
- sriracha or sweet chilli sauce, to serve

## Directions

1. Mince the chicken thigh with a cleaver and set aside.
1. Using the pestle and mortar, grind spring onions, chillies, and garlic until very fine.
1. Add minced chicken and continue to grind till mixtures resembles pate.
1. Transfer the mince to a mixing bowl, add egg, lime juice, fish sauce, cornflour, pepper, and sugar.
1. Mix well, kneading until the mixture is thick and dough-like in consistency.
1. Leave mixture to firm up in the fridge (about an hour).
1. Take about 2 tablespoons of mixture and shape it around a lemongrass stalk.
1. Repeat with remaining mixture until all are used up. Brush lightly with canola oil.
1. Heat the grill and cook the satay for 5–8 minutes, turning frequently until the chicken mixture is slightly charred. Serve warm with sweet chilli sauce.

https://recipes.fandom.com/wiki/Lemongrass_Chicken_Satay
"""
        }


soup : DecisionTree
soup =
    Leaf
        { label = "Chorizo Soup"
        , detail = Just """
## Ingredients

- 1 pound firm-texture chorizo
- 1 large onion, chopped, red, white, or yellow only or (5 tablespoons onion powder)
- 3 cloves garlic, minced or (5 tablespoons garlic powder)
- ½ cup dehydrated masa flour or yellow cornmeal
- 3 diced roasted green chiles, skins and seeds removed, or (1 can chopped green chiles)
- 7 cups chicken broth, store-bought or homemade
- 4 teaspoons paprika
- ¾ cup shredded jack cheese
- ½ cup minced cilantro

## Directions

1. Remove chorizo casings and crumble this into a 5- to 6-quart pan; just add the onion and garlic or the onion powder and garlic powder. Stir often over medium high heat until the meat and onion are browned, about 15 minutes.
1. Mix masa with the chorizo base, then stir in chiles, paprika, and the chicken broth.
1. Stirring often, bring to a boil over high heat. Simmer gently 20 minutes to blend flavors; stir frequently.
1. Skim fat from the surface as it accumulates and discard.
1. Ladle soup into bowls; just add the cheese and cilantro to taste. Serve warm and plain with any main dish, side dish, or appetizer.

https://recipes.fandom.com/wiki/Chorizo_Soup
"""
        }


quiche : DecisionTree
quiche =
    Leaf
        { label = "Sausage and Potato Quiche"
        , detail = Just """
## Ingredients

- 1½ cups sausage (browned/drained/crumbled)
- 1¼ cups frozen shredded hash brown potatoes
- 1 cup shredded Cheddar cheese
- 5 eggs
- ½ cup milk
- ¼ teaspoon salt
- ⅛ teaspoon pepper
- grated Parmesan cheese and paprika (optional)

## Directions

1. In a skillet, brown sausage and drain.
1. Spoon into an ungreased 10-inch pie pan.
1. Top with potatoes and cheddar cheese.
1. In a bowl, beat eggs, milk, salt and pepper; pour over cheese.
1. Sprinkle with Parmesan cheese and paprika.
1. Bake uncovered, in a 375°F oven for 30 – 35 minutes or until golden brown.

https://recipes.fandom.com/wiki/Sausage_and_Potato_Quiche
"""
        }


stroganoff : DecisionTree
stroganoff =
    Leaf
        { label = "Meatball Stroganoff"
        , detail = Just """
## Ingredients

- 2 pounds lean ground Beef
- 1½ cups soft breadcrumbs (3 slices bread)
- ½ cup finely chopped Onion
- ½ cup finely chopped celery
- 1 tablespoon worcestershire sauce
- 2 eggs
- 2 teaspoons garlic salt
- ¼ teaspoon ground black pepper
- 1 1-ounce package Mushroom soup mix
- 1 cup beef broth (canned or made with bouillon cube)
- 1 tablespoon dry white wine
- 1 tablespoon sour cream
- 1½ cups hot cooked rice

## Directions

1. Combine Beef, breadcrumbs, Onion, celery, worcestershire sauce, eggs, garlic salt and pepper; mix thoroughly.
1. Shape into 2 dozen balls 1½ inches in diameter.
1. Place in buttered shallow baking pan.
1. Bake at 375°F for 20 minutes.
1. Prepare soup mix according to package directions using beef broth for the liquid.
1. Add meat balls.
1. Cover and simmer 10 minutes.
1. Stir in wine and sour cream.
1. Heat; then serve over beds of fluffy rice.

https://recipes.fandom.com/wiki/Meatball_Stroganoff
"""
        }
