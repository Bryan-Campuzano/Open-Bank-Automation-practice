Feature: Registro de usuario

  Background:
    # URL base de la API
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Registrar un nuevo usuario
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "felixsmith@example.com",
      "username": "felixsmith",
      "password": "String",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 201
    And match response.email == "felixsmith@example.com"
