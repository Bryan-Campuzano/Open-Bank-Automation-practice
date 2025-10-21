Feature: Registro de Usuario - POST /users
  Validar el comportamiento del endpoint de creación de usuarios

  Background:
    * url https://apiexplorer-ii-sandbox.openbankproject.com/operationid/OBPv5.1.0-createAtm?version=OBPv5.1.0
    * path 'users'
    * configure headers = { 'Content-Type': 'application/json' }

  # 1.1 Registro exitoso con datos válidos
  Scenario: Registro exitoso con datos válidos
    * def body =
    """
    {
      "email": "user" + (Math.random() * 10000) + "@test.com",
      "password": "Password123!",
      "name": "Usuario Nuevo"
    }
    """
    Given request body
    When method post
    Then status 201
    And match response contains { user_id: '#string', email: '#string', created_at: '#string' }

  # 1.2 Registro con email duplicado
  Scenario: Registro con email duplicado
    * def email = "duplicado@test.com"
    * def body = { email: email, password: "Password123!", name: "Usuario Duplicado" }
    Given request body
    When method post
    Then status 409
    And match response.message == "Email already exists"

  # 1.3 Registro con contraseña débil
  Scenario: Registro con contraseña débil
    * def body = { email: "weakpass@test.com", password: "123", name: "Weak User" }
    Given request body
    When method post
    Then status 400
    And match response.message contains "password"

  # 1.4 Registro sin campo obligatorio (email)
  Scenario: Registro sin campo obligatorio
    * def body = { password: "Password123!", name: "Sin Email" }
    Given request body
    When method post
    Then status 400
    And match response.message contains "email"

  # 1.5 Registro con formato inválido de correo
  Scenario: Registro con formato inválido de correo
    * def body = { email: "correo_invalido", password: "Password123!", name: "Correo Inválido" }
    Given request body
    When method post
    Then status 422
    And match response.message contains "email"

  # 1.6 Registro con payload vacío
  Scenario: Registro con payload vacío
    * def body = {}
    Given request body
    When method post
    Then status 400

  # 1.7 Validar estructura de respuesta
  Scenario: Validar estructura de respuesta
    * def body =
    """
    {
      "email": "estructura" + (Math.random() * 10000) + "@test.com",
      "password": "Password123!",
      "name": "Estructura Test"
    }
    """
    Given request body
    When method post
    Then status 201
    And match response contains { user_id: '#string', email: '#string', created_at: '#string' }

  # 1.8 Validar tiempo de respuesta < 500ms
  Scenario: Validar tiempo de respuesta
    * def body =
    """
    {
      "email": "tiempo" + (Math.random() * 10000) + "@test.com",
      "password": "Password123!",
      "name": "Rapido"
    }
    """
    * def start = karate.timestamp()
    Given request body
    When method post
    * def end = karate.timestamp()
    * def elapsed = end - start
    Then status 201
    And assert elapsed < 500

  # 1.9 Registro y verificación de existencia posterior
  Scenario: Registro y autenticación posterior
    * def email = "flujo" + (Math.random() * 10000) + "@test.com"
    * def body = { email: email, password: "Password123!", name: "Flujo" }
    Given request body
    When method post
    Then status 201
    * def loginBody = { email: email, password: "Password123!" }
    Given path 'login'
    And request loginBody
    When method post
    Then status 200
    And match response contains { token: '#string' }

  # 1.10 Registro masivo (5 usuarios consecutivos)
  Scenario: Registro masivo de 5 usuarios consecutivos
    * def registerUser =
    """
    function(i){
      var body = {
        email: "massive" + i + "@test.com",
        password: "Password123!",
        name: "Usuario " + i
      };
      var res = karate.call({ method: 'post', url: 'https://api.tuservidor.com/users', headers: { 'Content-Type': 'application/json' }, body: body });
      return res.responseStatus == 201;
    }
    """
    * def success = true
    * def loop =
    """
    function(){
      for (var i = 0; i < 5; i++) {
        if (!registerUser(i)) return false;
      }
      return true;
    }
    """
    * def result = loop()
    Then assert result == true
