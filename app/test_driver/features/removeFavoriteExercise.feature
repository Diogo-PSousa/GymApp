Feature: Remove Exercise from Favorites List
  If a user removes an exercise from his favorites list, it should disappear from that page

  Scenario Outline: User remove  exercise from their favorites
    Given the user is logged-in
    And the user is on the favorites exercises page
    When they click the "Favorite button" on the exercise "<exercise>"
    And they click on the "Remove button" from the warning
    Then the exercise "<exercise>" disappears from the favorites page

    Examples:
      | exercise            |
      | Chest Dips          |
      | T-Bar Rows          |
      | Hammer Curl         |
      | Overhead Extensions |
      | Leg Press Machine   |
      | Lateral Raise       |
      | Plank               |