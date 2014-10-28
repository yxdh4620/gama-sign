###
# gama-sign main
# User YuanXiangDong
# date 2014-06-13 10:50:00
###

oauthSign = require "oauth-sign"
_ = require 'underscore'


DEFAULT_OVER_MILLISECONDS = 1000*60*10

#http 方法的数组枚举
HTTP_METHODS = ['GET', 'POST', 'PUT', 'DELETE']

#默认的签名参数名称
DEFAULT_SIGN_NAME = "sign"

#不参与计算sign的params
DEFAULT_IGNORE_PARAMS = []



## TODO 建立一个sign_mode的枚举
#SIGN_MODE

GamaSign =

  #验证时间戳
  # param timestamp :时间戳（毫秒数）
  # param milliseconds : 允许的时间间隔
  # return boolean true: 通过验证 false: 未通过验证
  verifyTimestamp : (timestamp, milliseconds) ->
    return false unless timestamp?
    milliseconds = parseInt(milliseconds || DEFAULT_OVER_MILLISECONDS)
    timestamp = parseInt(timestamp,10)
    return new Date().getTime() < (timestamp+milliseconds)

  # 验证http的方法：
  # param httpMethod : http 的方法
  # return boolean true: 通过验证， false: 未通过验证
  verifyMethod : (httpMethod) ->
    return httpMethod? and _.isString(httpMethod) and _.indexOf(HTTP_METHODS, httpMethod.toUpperCase()) != -1

  #签名：
  # param httpMethod: String（必须） http 请求的方式（"GET"，"POST"）
  # param baseUri: String(必须) http 请求的地址
  # param params: Object(可选) http 请求的参数
  # param ignoreParams: Array(可选)
  # param accessKeyId: String(必须)
  # param accessKeySecret: String (可选)
  # return String 计算后得到的签名
  makeSign : (httpMethod, baseUri, params, ignoreParams, accessKeyId, accessKeySecret) ->
    params = params||{}
    ignoreParams = ignoreParams||{}
    sign = oauthSign.hmacsign(httpMethod, baseUri, @removeIgnoreParams(params, ignoreParams), accessKeyId, accessKeySecret)
    return sign

  # 去除不参与计算sign的params
  removeIgnoreParams: (params, ignoreParams) ->
    ignoreParams = ignoreParams||[]
    newParams = _.clone(params||{})
    for key, val of newParams
      if key is DEFAULT_SIGN_NAME or _.indexOf(ignoreParams, key) != -1
        delete newParams[key]
    return newParams

module.exports=GamaSign
