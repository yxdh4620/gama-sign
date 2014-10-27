###
# utils/crypto_util 的测试类
###

should = require 'should'
debug = require('debug')('gama-search::tests::crypto_util_test')
gamaSign = require '../index'

accessKeyId = 'testid'
accessKeySecret = 'testsecret'




describe "crypto_util test", ->

  before () ->
    #TODO before

  describe "tests", ->

    it 'verifyTimestamp test', (done) ->
      console.log gamaSign.verifyTimestamp(new Date().getTime()-10000000)
      done()




