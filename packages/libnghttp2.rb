require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.50.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0-1_armv7l/libnghttp2-1.50.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0-1_armv7l/libnghttp2-1.50.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0-1_i686/libnghttp2-1.50.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.50.0-1_x86_64/libnghttp2-1.50.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9e5436c76f6ebdaaae493c95d2e2c12e61444a93b03d13927e5429c40451df3b',
     armv7l: '9e5436c76f6ebdaaae493c95d2e2c12e61444a93b03d13927e5429c40451df3b',
       i686: '55cc3719629bb2086909b9d8542c1c2524039028da0e18c49b8ebfb44fdec0b8',
     x86_64: '1c2011cfb262d79a8a280d6a914a37a362e119ea7c95efa3882063cd160babe2'
  })

  depends_on 'glibc' # R
  depends_on 'jansson'
  depends_on 'jemalloc'
  depends_on 'libev' => :build
  depends_on 'py3_cython' => :build

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
        -DENABLE_SHARED_LIB=ON \
        -DENABLE_STATIC_LIB=ON .."
      system 'mold -run samu'
    end
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
