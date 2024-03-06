Feature: Add food to nutrition diary
  If a user adds a certain food to his nutrition diary, its calories should be added to the total

  Scenario Outline: User adds food to his nutrition diary
    Given the user is logged-in
    And the user is on the nutrition page
    When they click add in the "<meal>" section
    And they search for the food "Peito de frango com pele, cru" and add "<quantity>" grams of it
    Then the total calories should be '<calories>'

    Examples:
      | meal      | quantity | calories |
      | Breakfast | 100      | 177.0    |
      | Lunch     | 100      | 354.0    |
      | Dinner    | 100      | 531.0    |
      | Breaks    | 100      | 708.0    |


