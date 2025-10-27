Feature: Registro de usuario sin campo obligatorio (email)

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Intentar registrar un usuario sin email
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "username": "noemailuser",
      "password": "Passw0rd!23",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 400
    And match response.message contains 'No usable value for email'
    * print 'Error por campo obligatorio faltante:', response.message
