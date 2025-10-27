Feature: Validación de coordenadas de ATMs 

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Validar que todos los ATMs tengan coordenadas válidas
    Given path 'obp', 'v5.1.0', 'banks', 'gh.29.uk', 'atms'
    When method get
    Then status 200
    * def atms = response.atms
    
    # Extraer e imprimir coordenadas
    * def coordenadas = atms.map(x => { return { id: x.id, latitude: x.location.latitude, longitude: x.location.longitude } })
    * print 'Coordenadas de ATMs:', coordenadas
