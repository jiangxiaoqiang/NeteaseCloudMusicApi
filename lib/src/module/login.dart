part of '../module.dart';

//手机登录
Handler login_cellphone = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  cookie.add(Cookie('appver', '2.10.6'));
  final data = {
    'phone': query!['phone'],
    'countrycode': query['countrycode'],
    'password': Encrypted(md5.convert(utf8.encode(query['password'])).bytes as Uint8List).base16,
    'rememberLogin': 'true'
  };

  return request('POST', 'https://music.163.com/weapi/login/cellphone', data, crypto: Crypto.weapi, cookies: cookie, ua: 'pc');
};

// 登录刷新
Handler login_refresh = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/login/token/refresh', {}, crypto: Crypto.weapi, cookies: cookie, ua: 'pc');
};

// 登录状态 TODO: 以后再加

// 邮箱登录
Handler login = (query, cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'username': query!['email'],
    'password': Encrypted(md5.convert(utf8.encode(query['password'])).bytes as Uint8List).base16,
    'rememberLogin': 'true'
  };

  return request('POST', 'https://music.163.com/weapi/login', data, crypto: Crypto.weapi, cookies: cookie, ua: 'pc');
};

// 退出登录
Handler logout = (query, cookie) {
  return request('POST', 'https://music.163.com/weapi/logout', {}, crypto: Crypto.weapi, cookies: cookie, ua: 'pc');
};

// 检测手机号码是否已经注册
Handler cellphone_existence_check = (query, cookie) {
  final data = {'cellphone': query!['phone'], 'countrycode': query['countrycode']};
  return eapiRequest(
    'http://music.163.com/eapi/cellphone/existence/check',
    '/api/cellphone/existence/check',
    data,
    cookies: cookie,
  );
};

// 检测用户名是否已经注册
Handler activate_init_profile = (query, cookie) {
  final data = {'nickname': query!['nickname']};
  return eapiRequest(
    'http://music.163.com/eapi/activate/initProfile',
    '/api/activate/initProfile',
    data,
    cookies: cookie,
  );
};

Handler login_qr_key = (query, cookie) {
  const data = {'type': 1};
  return request(
    'POST',
    'https://music.163.com/weapi/login/qrcode/unikey',
    data,
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

Handler login_qr_check = (query, cookie) {
  final data = {
    'key': query!['key'],
    'type': 1,
  };
  return request(
    'POST',
    'https://music.163.com/weapi/login/qrcode/client/login',
    data,
    cookies: cookie,
    crypto: Crypto.weapi,
  );
};

Handler login_status = (query, cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/w/nuser/account/get',
    {},
    crypto: Crypto.weapi,
    cookies: cookie,
  );
};
