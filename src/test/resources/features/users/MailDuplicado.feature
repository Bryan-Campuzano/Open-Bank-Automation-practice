Feature: Registro de usuario duplicado

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Intentar registrar un usuario con email duplicado
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "felixsmith@example.com",
      "username": "felixsmith_dup",
      "password": "Passw0rd!23",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 400
    And match response.message == 'User already exists'