NUM = 10

bench_json_pack = (obj) ->
  before = new Date().valueOf() / 1000
  for x in [1..NUM]
    encoded = JSON.stringify(obj)
  after = new Date().valueOf() / 1000
  diff = after - before
  console.log('json2.js pack: ' + (NUM/diff) + ' qps')
  return encoded

bench_json_unpack = (json) ->
  before = new Date().valueOf() / 1000
  for x in [1..NUM]
    decoded = JSON.parse(json)
  after = new Date().valueOf() / 1000
  diff = after - before
  console.log('json2.js unpack: ' + (NUM/diff) + ' qps')
  return decoded

bench_msgpack_pack = (obj) ->
  before = new Date().valueOf() / 1000
  for x in [1..NUM]
    encoded = msgpack.pack(obj)
  after = new Date().valueOf() / 1000
  diff = after - before
  console.log('msgpack.js pack: ' + (NUM/diff) + ' qps')
  return encoded

bench_msgpack_unpack = (json) ->
  before = new Date().valueOf() / 1000
  for x in [1..NUM]
    decoded = msgpack.unpack(json)
  after = new Date().valueOf() / 1000
  diff = after - before
  console.log('msgpack.js unpack: ' + (NUM/diff) + ' qps')
  return decoded

window.onload = () ->
  console.log('== json2.jsとmsgpackのpackベンチ(10) ==')
  json_encoded_10000 = bench_json_pack(solid10)
  msgpack_encoded_10000 = bench_msgpack_pack(solid10)
  console.log('')

  console.log('== json2.jsとmsgpackのpackベンチ(10000) ==')
  json_encoded_10000 = bench_json_pack(solid10000)
  msgpack_encoded_10000 = bench_msgpack_pack(solid10000)
  console.log('')

  console.log('== json2.jsとmsgpackのpackベンチ(100000) ==')
  json_encoded_100000 = bench_json_pack(solid100000)
  msgpack_encoded_100000 = bench_msgpack_pack(solid100000)
  console.log('')

  console.log('== json2.jsとmsgpackのunpackベンチ(10000) ==')
  bench_json_unpack(json_encoded_10000)
  bench_msgpack_unpack(msgpack_encoded_10000)
  console.log('')

  console.log('== json2.jsとmsgpackのunpackベンチ(100000) ==')
  bench_json_unpack(json_encoded_100000)
  bench_msgpack_unpack(msgpack_encoded_100000)
  console.log('')

