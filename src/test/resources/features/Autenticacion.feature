Feature: Pruebas de Autenticación - /login (POST)

  Background:
    * url 'https://apiexplorer-ii-sandbox.openbankproject.com/operationid/OBPv5.1.0-createAtm?version=OBPv5.1.0'

  # 2.1 Inicio de sesión válido
  Scenario: 2.1 Inicio de sesión válido
    Given path 'login'
    And request { username: 'usuario_valido', password: 'password_valida' }
    When method post
    Then status 200
    And match response contains { token: '#notnull' }

  # 2.2 Credenciales incorrectas
  Scenario: 2.2 Credenciales incorrectas
    Given path 'login'
    And request { username: 'usuario_valido', password: 'password_incorrecta' }
    When method post
    Then status 401
    And match response.message == 'Credenciales incorrectas'

  # 2.3 Usuario inexistente
  Scenario: 2.3 Usuario inexistente
    Given path 'login'
    And request { username: 'usuario_no_existente', password: 'cualquier_password' }
    When method post
    Then status 404
    And match response.message == 'Usuario no encontrado'

  # 2.4 Contraseña vacía
  Scenario: 2.4 Contraseña vacía
    Given path 'login'
    And request { username: 'usuario_valido', password: '' }
    When method post
    Then status 400
    And match response.message == 'Contraseña requerida'

  # 2.5 Email con formato incorrecto
  Scenario: 2.5 Email con formato incorrecto
    Given path 'login'
    And request { username: 'email_incorrecto', password: 'password_valida' }
    When method post
    Then status 422
    And match response.message == 'Formato de email inválido'

  # 2.6 Token devuelto tiene formato JWT válido

  Scenario: 2.6 Token JWT válido
    Given path 'login'
    And request { username: 'usuario_valido', password: 'password_valida' }
    When method post
    Then status 200
    * def token = response.token
    * def parts = token.split('\\.')
    * match parts.length == 3


  # 2.7 Tiempo de respuesta < 400 masivo
    Scenario: 2.7 Performance login
    Given path 'login'
    And request { username: 'usuario_valido', password: 'password_valida' }
    When method post
    Then status 200
    * assert responseTime < 400


  # 2.8 Intentos fallidos múltiples bloquean usuario
  Scenario: 2.8 Bloqueo por intentos fallidos
    * def i = 0
    * while(i < 5)
      Given path 'login'
      And request { username: 'usuario_valido', password: 'password_incorrecta' }
      When method post
      Then status 401
      * i = i + 1
    Given path 'login'
    And request { username: 'usuario_valido', password: 'password_incorrecta' }
    When method post
    Then status 429
    And match response.message == 'Usuario bloqueado temporalmente'

  # 2.9 Login después de bloqueo temporal

  Scenario: 2.9 Login tras periodo de bloqueo
    # Aquí debes esperar el periodo de desbloqueo manual o simulado
    Given path 'login'
    And request { username: 'usuario_valido', password: 'password_valida' }
    When method post
    Then status 200
    And match response.token != null

  # 2.10 Reautenticación con token expirado
  Scenario: 2.10 Reautenticación con token expirado
    Given path 'login'
    And header Authorization = 'Bearer token_expirado'
    When method post
    Then status 403
    And match response.message == 'Token expirado'
