###
  unix timestampを取得する関数
  @param d {moment()|Number}
###
getUnixTimestamp=(d)->
  dType = typeof d
  if dType == 'number' or dType == 'object' then return moment(d).valueOf() / 1000
  return moment().valueOf() / 1000

unixTimestamp2Date=(d)->
  return moment.unix(d)

class isMobile
  constructor: ()->
    @reAndroid = new RegExp(/Android/i)
    @reBlackBerry = new RegExp(/BlackBerry/i)
    @reIOSPhone = new RegExp(/iPhone|iPod/i)
    @reIOSTablet = new RegExp(/iPad/i)
    @reOperaMini = new RegExp(/Opera Mini/i)
    @reOperaMobile = new RegExp(/Opera Mobi/i)
    @reOperaTablet = new RegExp(/Opera Tablet/i)
    @reWindows = new RegExp(/Windows Phone|IEMobile/i)

  Android:(userAgent=navigator.userAgent)->
    return userAgent.match(@reAndroid) != null

  BlackBerry:(userAgent=navigator.userAgent)->
    return userAgent.match(@reBlackBerry) != null

  iOSPhone:(userAgent=navigator.userAgent)->
    return userAgent.match(@reIOSPhone) != null

  iOSTablet:(userAgent=navigator.userAgent)->
    return userAgent.match(@reIOSTablet) != null

  OperaMini:(userAgent=navigator.userAgent)->
    return userAgent.match(@reOperaMini) != null

  OperaMobile:(userAgent=navigator.userAgent)->
    return userAgent.match(@reOperaMobile) != null

  OperaTablet:(userAgent=navigator.userAgent)->
    return userAgent.match(@reOperaTablet) != null

  Windows:(userAgent=navigator.userAgent)->
    return userAgent.match(@reWindows) != null

  any:(userAgent=navigator.userAgent)->
    return @BlackBerry(userAgent) || @iOSPhone(userAgent) || @iOSTablet(userAgent) || @OperaMini(userAgent) || @OperaMobile(userAgent) || @OperaTablet(userAgent) || @Windows(userAgent) || @Android(userAgent)

