Feature: Successful logout for logged in user
  The user should be logged out of the app when they click the logout button

  Scenario Outline: User logs out
    Given the user is logged-in
    When they press the "<button>" button
    Then they are redirected to the "<page>"

    Examples:
      | button        | page       |
      | logout_button | Login Page |

