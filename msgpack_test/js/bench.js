// Generated by CoffeeScript 1.4.0
var NUM, bench_json_pack, bench_json_unpack, bench_msgpack_pack, bench_msgpack_unpack;

NUM = 10;

bench_json_pack = function(obj) {
  var after, before, diff, encoded, x, _i;
  before = new Date().valueOf() / 1000;
  for (x = _i = 1; 1 <= NUM ? _i <= NUM : _i >= NUM; x = 1 <= NUM ? ++_i : --_i) {
    encoded = JSON.stringify(obj);
  }
  after = new Date().valueOf() / 1000;
  diff = after - before;
  console.log('json2.js pack: ' + (NUM / diff) + ' qps');
  return encoded;
};

bench_json_unpack = function(json) {
  var after, before, decoded, diff, x, _i;
  before = new Date().valueOf() / 1000;
  for (x = _i = 1; 1 <= NUM ? _i <= NUM : _i >= NUM; x = 1 <= NUM ? ++_i : --_i) {
    decoded = JSON.parse(json);
  }
  after = new Date().valueOf() / 1000;
  diff = after - before;
  console.log('json2.js unpack: ' + (NUM / diff) + ' qps');
  return decoded;
};

bench_msgpack_pack = function(obj) {
  var after, before, diff, encoded, x, _i;
  before = new Date().valueOf() / 1000;
  for (x = _i = 1; 1 <= NUM ? _i <= NUM : _i >= NUM; x = 1 <= NUM ? ++_i : --_i) {
    encoded = msgpack.pack(obj);
  }
  after = new Date().valueOf() / 1000;
  diff = after - before;
  console.log('msgpack.js pack: ' + (NUM / diff) + ' qps');
  return encoded;
};

bench_msgpack_unpack = function(json) {
  var after, before, decoded, diff, x, _i;
  before = new Date().valueOf() / 1000;
  for (x = _i = 1; 1 <= NUM ? _i <= NUM : _i >= NUM; x = 1 <= NUM ? ++_i : --_i) {
    decoded = msgpack.unpack(json);
  }
  after = new Date().valueOf() / 1000;
  diff = after - before;
  console.log('msgpack.js unpack: ' + (NUM / diff) + ' qps');
  return decoded;
};

window.onload = function() {
  var json_encoded_10, json_encoded_10000, json_encoded_100000, msgpack_encoded_10, msgpack_encoded_10000, msgpack_encoded_100000;
  console.log('== json2.jsとmsgpackのpackベンチ(10) ==');
  json_encoded_10 = bench_json_pack(solid10);
  msgpack_encoded_10 = bench_msgpack_pack(solid10);
  console.log('');
  console.log('== json2.jsとmsgpackのpackベンチ(10000) ==');
  json_encoded_10000 = bench_json_pack(solid10000);
  msgpack_encoded_10000 = bench_msgpack_pack(solid10000);
  console.log('');
  console.log('== json2.jsとmsgpackのpackベンチ(100000) ==');
  json_encoded_100000 = bench_json_pack(solid100000);
  msgpack_encoded_100000 = bench_msgpack_pack(solid100000);
  console.log('');
  console.log('== json2.jsとmsgpackのunpackベンチ(10) ==');
  bench_json_unpack(json_encoded_10);
  bench_msgpack_unpack(msgpack_encoded_10);
  console.log('');
  console.log('== json2.jsとmsgpackのunpackベンチ(10000) ==');
  bench_json_unpack(json_encoded_10000);
  bench_msgpack_unpack(msgpack_encoded_10000);
  console.log('');
  console.log('== json2.jsとmsgpackのunpackベンチ(100000) ==');
  bench_json_unpack(json_encoded_100000);
  bench_msgpack_unpack(msgpack_encoded_100000);
  return console.log('');
};
