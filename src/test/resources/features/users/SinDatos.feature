Feature: Registro de usuario con payload vacío

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Intentar registrar un usuario sin enviar datos
    Given path 'obp', 'v4.0.0', 'users'
    And request {}
    When method post
    Then status 400
    And match response.message contains 'No usable value'
    * print 'Error por payload vacío:', response.message
