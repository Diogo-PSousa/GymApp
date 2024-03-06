Feature: Click on Muscle
  The Screen with the exercises for the specific muscle group should be shown when clicked on it.

  Scenario Outline: User searches exercises by muscle group
    Given the user is logged-in
    And the user is on the muscle exercises page
    When they select the "<muscle>" muscle group
    Then the exercise "<exercise>" group should appear

    Examples:
      | muscle    | exercise       |
      | Chest     | Bench-Press    |
      | Back      | Lat Pulldowns  |
      | Biceps    | Dumbbell Curl  |
      | Triceps   | Triceps Dips   |
      | Legs      | Deadlift       |
      | Shoulders | Shoulder Press |
      | Abs       | Crunches       |