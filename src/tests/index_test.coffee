###
# utils/crypto_util 的测试类
###

should = require 'should'
debug = require('debug')('gama-search::tests::crypto_util_test')
gamaSign = require '../index'

accessKeyId = 'testid'
accessKeySecret = 'testsecret'

httpMethod = 'GET'
baseUri = 'http://localhost:8086'

params =
  id:'afdafaf'
  name:'哈哈'
  icons:4234234
  props:
    242342:1
    434535:2
    345435:3
  text:"asfdadlfalksdjfkjsafkhashdfkldasklfjakjsdkfjkadsfkhkdashfkhkaldsjkfjdklsjf"

ignoreParams = ['icons', 'props']



describe "crypto_util test", ->

  before () ->
    #TODO before

  describe "tests", ->

    it 'verifyTimestamp test', (done) ->
      console.log gamaSign.verifyTimestamp(new Date().getTime()-10000000)
      done()

    it 'verifyMethod test', (done) ->
      for method in ['GET','PPST','POST','put', 'delete']
        verify = gamaSign.verifyMethod method
        console.log "method:#{method} verify:#{verify}"
      done()

    it 'removeIgnoreParams test', (done)->
      newParams = gamaSign.removeIgnoreParams params, ['icons', 'props']
      console.dir newParams
      console.dir params
      done()

    it 'makeSign test', (done) ->
      sign = gamaSign.makeSign httpMethod, baseUri, params, ignoreParams, accessKeyId, accessKeySecret
      console.log sign
      params['sign'] = sign
      sign = gamaSign.makeSign httpMethod, baseUri, params, ignoreParams, accessKeyId, accessKeySecret
      console.log sign
      done()



