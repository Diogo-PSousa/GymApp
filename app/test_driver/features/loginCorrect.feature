Feature: Successful login for existing user
  If a user already has an account in the app and fills out the login form, they are sent to the Homepage.

  Scenario Outline: User logs in correctly
    Given the user enters their email "<email>"
    And they enter their password "<password>"
    When they press the "<button>"
    Then they are redirected to the "<page>"

    Examples:
      | email                   | password | button       | page      |
      | up202005334@g.uporto.pt | lmao123  | login_button | Home Page |

