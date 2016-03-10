_ = require 'lodash'
GetAuthorizedSubscriptionTypes = require '../'

describe 'GetAuthorizedSubscriptionTypes', ->
  beforeEach ->
    @sut = new GetAuthorizedSubscriptionTypes {}

  describe '->do', ->
    context 'with no types specified', ->
      beforeEach (done) ->
        request =
          metadata:
            responseId: 'its-electric'
            uuid: 'electric-eels'
            messageType: 'received'
            options: {}
          rawData: '{}'

        @sut.do request, (error, @response) => done error

      it 'should return a 204', ->
        expectedResponse =
          metadata:
            responseId: 'its-electric'
            code: 204
            status: 'No Content'
          data:
            types: []
            uuid: 'electric-eels'

        expect(@response).to.deep.equal expectedResponse

    context 'with some types specified', ->
      beforeEach (done) ->
        request =
          metadata:
            responseId: 'its-electric'
            uuid: 'electric-eels'
            messageType: 'received'
            options: {}
          rawData: '{"types": ["broadcast","config"]}'

        @sut.do request, (error, @response) => done error

      it 'should return a 204', ->
        expectedResponse =
          metadata:
            responseId: 'its-electric'
            code: 204
            status: 'No Content'
          data:
            types: [
              'broadcast'
              'config'
            ]
            uuid: 'electric-eels'

        expect(@response).to.deep.equal expectedResponse

    context 'with invalid types specified', ->
      beforeEach (done) ->
        request =
          metadata:
            responseId: 'its-electric'
            uuid: 'electric-eels'
            messageType: 'received'
            options: {}
          rawData: '{"types": ["cable","tv"]}'

        @sut.do request, (error, @response) => done error

      it 'should return a 204', ->
        expectedResponse =
          metadata:
            responseId: 'its-electric'
            code: 204
            status: 'No Content'
          data:
            types: []
            uuid: 'electric-eels'

        expect(@response).to.deep.equal expectedResponse
