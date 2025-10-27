Feature: Consultar ATMs de un banco inexistente

  Background:
    * url 'https://apisandbox.openbankproject.com'

  Scenario: Consultar ATMs con un BANK_ID inexistente
    # ID de banco inválido
    Given path 'obp', 'v5.1.0', 'banks', 'BANK_ID_INVALIDO', 'atms'
    When method get
    Then status 404
    * print 'Respuesta:', response
    * match response.message contains 'Bank not found'
