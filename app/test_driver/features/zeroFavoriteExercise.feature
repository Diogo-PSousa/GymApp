Feature: Zero Exercises in Favorites List
  If a user has no exercises un his favorites list, a warning text should appear

  Scenario: User has no exercises in his favorites
    Given the user is logged-in
    And the user is on the favorites exercises page
    When the user has not added any favorite exercises to his "Favorites list"
    Then the page should say "You don't have any favorite exercises yet!"