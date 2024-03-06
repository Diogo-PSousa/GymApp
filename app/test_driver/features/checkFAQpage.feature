Feature: Check FAQ Page
  The FAQ page should be accessible and show some commonly asked questions and answers, so that users to understand the app.

  Scenario Outline: User checks the FAQ Page
    Given the user is logged-in
    When they click the FAQ tab
    Then they are redirected to the "FAQ Page"
    And they can get the answer to their question: "<question>"

    Examples:
      | question                                                  |
      | What does this gym app do?                                |
      | How do I add an exercise to my favorite list?             |
      | Does the app have instructional images for exercises?     |
      | How does the app track nutrition?                         |
      | Can I edit my profile information?                        |
      | How does the app calculate estimated daily calorie needs? |
