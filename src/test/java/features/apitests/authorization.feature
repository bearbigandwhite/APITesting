Feature: Verify that results and errors are properly returned by the API during authorization

  Background:
    * url 'http://207.154.242.0:8888'

  Scenario: User can sing in

    Given path '/v1/authorize'
    And request { login: '123', pwd: '45' }
    When method POST
     Then status 200
    And match $ == {Result:'true',Details:'AAABBBCCCDDDEEE=='}

  Scenario: User can't sing in

    Given path '/v1/authorize'
    And request { login: '123', pwd: '47' }
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Failed to authorize'}


  Scenario: User doesn't exists

    Given path '/v1/authorize'
    And request { login: '123', pwd: '47' }
    When method POST
    Then status 401
    And match $ == {Result:'0',Details:'User does not exists'}

