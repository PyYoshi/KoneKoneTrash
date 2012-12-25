# -*- coding:utf-8 -*-
__author__ = 'PyYoshi'

import base64
import time
import os

import msgpack
import simplejson
import gzip

TEST_OBJ = {
    'key': 1234,
    'value': 'aiueo',
    'list':[1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0],
    'dict':{
        'k':1,
        'v':u'あいうえお'
    },
    'list-dict':[
        {
            'k':1,
            'v':u'あいうえお'
        },
        {
            'k':2,
            'v':u'かきくけこ'
        },
        {
            'k':3,
            'v':u'さしすせそ'
        },
        {
            'k':4,
            'v':u'たちつてと'
        },
        {
            'k':5,
            'v':u'なにぬねの'
        },
    ],
    # http://interfacelift.com/wallpaper/details/3161/early_morning_fishing.html
    'bin': base64.b64encode(file('./03161_earlymorningfishing_1920x1080.jpg','rb').read())
}
OUTPUT_SIMPLEJSON_FILE = './simplejson.dat'
OUTPUT_SIMPLEJSON_GZIP_FILE = './simplejson.dat.gzip'
OUTPUT_MSGPACK_FILE = './msgpack.dat'
OUTPUT_MSGPACK_GZIP_FILE = './msgpack.dat.gzip'

def simplejson_pack(obj):
    simplejson.dump(obj,file(OUTPUT_SIMPLEJSON_FILE,'wb'))
def simplejson_packb(obj):
    return simplejson.dumps(obj)

def msgpack_pack(obj):
    msgpack.dump(obj,file(OUTPUT_MSGPACK_FILE,'wb'))
def msgpack_packb(obj):
    return msgpack.dumps(obj)

def simplejson_unpack():
    return simplejson.load(file(OUTPUT_SIMPLEJSON_FILE,'rb'))
def simplejson_unpackb(res):
    return simplejson.loads(res)

def msgpack_unpack():
    return msgpack.unpack(file(OUTPUT_MSGPACK_FILE,'rb'))
def msgpack_unpackb(res):
    return msgpack.unpackb(res)

def compress_gzip(input_path,output_path):
    f = gzip.open(output_path,'wb')
    try:
        f.write(file(input_path,'rb').read())
    finally:
        f.close()

def calc_compression_ratio(orig_size, compressed_size):
    return round(float(compressed_size) / float(orig_size),2) * 100

def main():
    num = 10000

    print(u'== simplejsonとmsgpackのpack処理のベンチ ==')

    before = time.time()
    for x in xrange(num):
        simplejson_packb(TEST_OBJ)
    after = time.time()
    diff = after - before
    print("simplejson-packb: {0} qps".format(num/diff))

    before = time.time()
    for x in xrange(num):
        msgpack_packb(TEST_OBJ)
    after = time.time()
    diff = after - before
    print("msgpack-packb: {0} qps".format(num/diff))

    print(u'== simplejsonとmsgpackのunpack処理のベンチ ==')

    simplejson_packb_result = simplejson_packb(TEST_OBJ)
    before = time.time()
    for x in xrange(num):
        simplejson_unpackb(simplejson_packb_result)
    after = time.time()
    diff = after - before
    print("simplejson-unpackb: {0} qps".format(num/diff))

    msgpack_packb_result = msgpack_packb(TEST_OBJ)
    before = time.time()
    for x in xrange(num):
        msgpack_unpackb(msgpack_packb_result)
    after = time.time()
    diff = after - before
    print("msgpack-unpackb: {0} qps".format(num/diff))

    """
    print(u'== simplejsonとmsgpackのpackデータをgzipで圧縮した時の圧縮率 ==')
    # simplejsonとmsgpackでpackしたデータファイルの生成
    simplejson_pack(TEST_OBJ)
    msgpack_pack(TEST_OBJ)
    # 各オリジナルファイルサイズの取得
    simplejson_dat_size_orig = os.path.getsize(OUTPUT_SIMPLEJSON_FILE)
    msgpack_dat_size_orig = os.path.getsize(OUTPUT_MSGPACK_FILE)
    # 各ファイルをgzip圧縮
    compress_gzip(OUTPUT_SIMPLEJSON_FILE,OUTPUT_SIMPLEJSON_GZIP_FILE)
    compress_gzip(OUTPUT_MSGPACK_FILE,OUTPUT_MSGPACK_GZIP_FILE)
    # 各圧縮後ファイルサイズの取得
    simplejson_dat_size_compressed = os.path.getsize(OUTPUT_SIMPLEJSON_GZIP_FILE)
    msgpack_dat_size_compressed = os.path.getsize(OUTPUT_MSGPACK_GZIP_FILE)
    # 結果
    print(u'simplejson.dat size: {0}'.format(simplejson_dat_size_orig))
    print(u'simplejson.dat.gzip: {0}'.format(simplejson_dat_size_compressed))
    print(u'simplejson.dat compression ratio: {0}%'.format(calc_compression_ratio(simplejson_dat_size_orig,simplejson_dat_size_compressed)))
    print(u'msgpack.dat size: {0}'.format(msgpack_dat_size_orig))
    print(u'msgpack.dat.gzip: {0}'.format(msgpack_dat_size_compressed))
    print(u'msgpack.dat compression ratio: {0}%'.format(calc_compression_ratio(msgpack_dat_size_orig,msgpack_dat_size_compressed)))

    # 生成したファイルの削除
    try:
        os.remove(OUTPUT_SIMPLEJSON_FILE)
        os.remove(OUTPUT_SIMPLEJSON_GZIP_FILE)
        os.remove(OUTPUT_MSGPACK_FILE)
        os.remove(OUTPUT_MSGPACK_GZIP_FILE)
    except Exception as e:
        pass
    """

if '__main__' in __name__:
    main()
