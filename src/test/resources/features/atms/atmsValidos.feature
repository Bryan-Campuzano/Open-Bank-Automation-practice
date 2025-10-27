Feature: Consultar ATMs válidos

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Obtener lista de ATMs válidos
    Given path 'obp', 'v5.1.0', 'banks', 'gh.29.uk', 'atms'
    When method get
    Then status 200
    * print 'Respuesta completa:', response

    # Definir la lista de ATMs
    * def atms = response.atms

    # Si el campo de validación existe, filtrar los válidos
    * def atmsValidos = karate.filter(atms, function(x){ return x.is_active == true })

    * print 'ATMs válidos encontrados:', atmsValidos
    * match atmsValidos == '#[]'
