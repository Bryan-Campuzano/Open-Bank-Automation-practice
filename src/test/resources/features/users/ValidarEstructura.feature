Feature: Registro de usuario con email inválido (sandbox limitation)

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: IVerificar estructura de respuesta de registro exitoso
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "validuser@example.com",
      "username": "validusername",
      "provider_id": "validusername",
      "password": "Passw0rd!23",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 201
    And match response contains 
    { 
      user_id: '#string', 
      email: '#string', 
      provider_id: '#string', 
      provider: '#string', 
      username: '#string',
      entitlements: { list: '#[]' }
    }
    * print 'Estructura de respuesta validada correctamente:', response