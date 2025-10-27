Feature: Validar tiempo de respuesta al registrar un usuario

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Verificar que la API responde en un tiempo aceptable
    Given path 'obp', 'v4.0.0', 'users'
    And request 
    """
    {
      "email": "checkuser@example.com",
      "username": "checkuser",
      "provider_id": "checkuser",
      "password": "StrongPassw0rd!",
      "first_name": "Simon",
      "last_name": "Redfern"
    }
    """
    When method post
    Then status 201
    And match response contains { 
      user_id: '#string', 
      email: '#string', 
      username: '#string'
    }
    * def createdUserId = response.user_id
    * print 'Usuario registrado con ID:', createdUserId
    
    #Paso 2: Verificar existencia del usuario
    Given path 'obp', 'v4.0.0', 'users', createdUserId
    When method get
    Then status 200
    And match response.user_id == createdUserId
    And match response.email == "checkuser@example.com"
    * print 'Usuario verificado exitosamente:', response
