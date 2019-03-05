Feature: Verify that results and errors are properly returned by the API during registration

  Background:
    * url 'http://207.154.242.0:8888'

  Scenario: User is registered with POST

    Given path '/v1/register'
    And request { email: 'jelena.p@b23222.com', phone: '+371 6111111', pwd: '111aaa', birthDate: '1988-06-25T00:00:00.000Z', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
     Then status 200
    And match $ == {Result:'true',Details:'none'}

  Scenario: User is registered with POST, but email exists

    Given path '/v1/register'
    And request { email: 'jelena.p@b12.com', phone: '+371 6111111', pwd: '111aaa', birthDate: '1988-06-25T00:00:00.000Z', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Field email already exists'}

  Scenario: User is registered with POST, but email field is missing

    Given path '/v1/register'
    And request { phone: '+371 6111111', pwd: '111aaa', birthDate: '1988-06-25T00:00:00.000Z', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Field email missed'}

  Scenario: User is registered with POST, but description field is missing

    Given path '/v1/register'
    And request { email: 'jelena.p@b12.com', phone: '+371 6111111', pwd: '111aaa', birthDate: '1988-06-25T00:00:00.000Z', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Field description missed'}

@@test
  Scenario: User is registered with POST, but birthDate field is missing

    Given path '/v1/register'
    And request { email: 'jelena.p@b12.com', phone: '+371 6111111', pwd: '111aaa', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Field email missed'}

  Scenario: User is registered with POST, but bad format

    Given path '/v1/register'
    And request { email: 'jelena.p@b121031.com', phone: '+371 6111111', pwd: '111aaa!', birthDate: '1988-06-25T00:00:00.000Z', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Field password bad format'}


  Scenario: User is registered with POST, but under 21 years old

    Given path '/v1/register'
    And request { email: 'jelena.p@b121030.com', phone: '+371 6111111', pwd: '111aaa!', birthDate: '2005-06-25T00:00:00.000Z', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', address: {country: 'US', city: 'New York', state: 'John Doe', zip: 'LV-1011', street: 'Ropazu 10'}}
    When method POST
    Then status 400
    And match $ == {Result:'0',Details:'Field birthDate bad format'}

