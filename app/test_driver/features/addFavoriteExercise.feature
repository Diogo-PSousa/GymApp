Feature: Add Exercise to Favorites List
  If a user adds an exercise to his favorites list, it should appear in the favorites list tab

  Scenario Outline: User adds exercise to their favorites
    Given the user is logged-in
    And the user is on the muscle exercises page
    When they select the "<muscle>" muscle group
    And they click the "Favorite button" on the exercise "<exercise>"
    Then the "<exercise>" should appear beneath the "<muscle>" in the Favorite Exercises page

    Examples:
      | muscle    | exercise            |
      | Chest     | Chest Dips          |
      | Back      | T-Bar Rows          |
      | Biceps    | Hammer Curl         |
      | Triceps   | Overhead Extensions |
      | Legs      | Leg Press Machine   |
      | Shoulders | Lateral Raise       |
      | Abs       | Plank               |