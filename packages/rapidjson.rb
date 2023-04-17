require 'package'

class Rapidjson < Package
  description 'A fast JSON parser/generator for C++ with both SAX/DOM style API'
  homepage 'https://rapidjson.org/'
  version '949c771'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Tencent/rapidjson.git'
  git_hashtag '949c771b03de448bdedea80c44a4a5f65284bfeb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rapidjson/949c771_armv7l/rapidjson-949c771-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rapidjson/949c771_armv7l/rapidjson-949c771-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rapidjson/949c771_i686/rapidjson-949c771-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rapidjson/949c771_x86_64/rapidjson-949c771-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e76429c8d3203d9a0f7ca780585de913fc93d2f2a6d3ce341d8d482191123f3b',
     armv7l: 'e76429c8d3203d9a0f7ca780585de913fc93d2f2a6d3ce341d8d482191123f3b',
       i686: '34c48918a0dcdcd612c9676c80ba2d9dd321125ecbbc68f8eeef3abf7531fb8e',
     x86_64: 'e65b7de8a8158d8ebe5b17454b23b295000ee1d4ad25b058c3f4631c686f4f50'
  })

  depends_on 'cmake' => :build
  depends_on 'ninja' => :build

  def self.build
    system "cmake -B builddir \
            #{CREW_CMAKE_OPTIONS} \
            -DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX} \
            -DRAPIDJSON_BUILD_DOC=OFF \
            -DRAPIDJSON_BUILD_EXAMPLES=OFF \
            -DRAPIDJSON_BUILD_TESTS=OFF \
            -G Ninja"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
