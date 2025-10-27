Feature: Validar tiempo de respuesta al registrar un usuario

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Verificar que la API responde en un tiempo aceptable
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "timinguser@example.com",
      "username": "timinguser",
      "provider_id": "timinguser",
      "password": "StrongPassw0rd!",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 201
    # Validar que la respuesta sea menor o igual a 2000 ms (2 segundos)
    And assert responseTime <= 2000
    * print 'Tiempo de respuesta (ms):', responseTime
