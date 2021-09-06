require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.44.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag 'v' + @_ver

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.44.0_armv7l/libnghttp2-1.44.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.44.0_armv7l/libnghttp2-1.44.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.44.0_i686/libnghttp2-1.44.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.44.0_x86_64/libnghttp2-1.44.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7409b33d59d3a48db51830a3a1522668a285641a20636078d9fea29d37435ca1',
     armv7l: '7409b33d59d3a48db51830a3a1522668a285641a20636078d9fea29d37435ca1',
       i686: '0f55cc49ebc2542942d6aff73efb876e89da22494892f28c310611ddb0849aff',
     x86_64: '1db2fa466e7c434dab211a202a85518f1607d0a9311d8ad7606f5cbd9a55635b',
  })

  depends_on 'jansson'
  depends_on 'jemalloc'
  depends_on 'libevent' => :build
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
        -DENABLE_EXAMPLES=OFF \
        -DENABLE_SHARED_LIB=ON \
        -DENABLE_STATIC_LIB=ON .."
      system 'samu'
    end
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
