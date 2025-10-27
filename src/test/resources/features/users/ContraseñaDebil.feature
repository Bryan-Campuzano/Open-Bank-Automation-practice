Feature: Registro de usuario con contraseña débil

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Intentar registrar un usuario con contraseña inválida
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "weakpassword@example.com",
      "username": "felixsmith",
      "password": "weakpass123", 
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 400
    And match response.message contains 'Invalid Password Format'
    * print 'Mensaje de error de contraseña débil:', response.message
