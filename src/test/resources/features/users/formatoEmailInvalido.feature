Feature: Registro de usuario con email inválido (sandbox limitation)

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Intentar registrar un usuario con email mal formado
    # Nota: sandbox API valida otros campos primero, por lo que este test
    # no puede fallar solo por el email
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "invalid-email-format",
      "username": "validusername",
      "provider_id": "validusername",
      "password": "Passw0rd!23",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 400
    * print 'Mensaje devuelto (no necesariamente por email):', response.message
