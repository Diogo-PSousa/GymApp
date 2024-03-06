Feature: Unsuccessful login for existing user
  If a user already doesn't have an account in the app and fills out the login form, they are shown a warning text.

  Scenario Outline: User logs in incorrectly
    Given the user enters their email "<email>"
    And they enter their password "<password>"
    When they press the "<button>"
    Then they are shown the text "Invalid email or password"

    Examples:
      | email                   | password | button       |
      | invalid-email@gmail.com | inv_pass | login_button |

