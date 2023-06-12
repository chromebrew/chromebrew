require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.52.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.52.0-py3.11_armv7l/libnghttp2-1.52.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.52.0-py3.11_armv7l/libnghttp2-1.52.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.52.0-py3.11_i686/libnghttp2-1.52.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.52.0-py3.11_x86_64/libnghttp2-1.52.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9e1dd21f94b5e6f0df0201cf86ced7c671b16608b6c557f2d7d116154171b6bb',
     armv7l: '9e1dd21f94b5e6f0df0201cf86ced7c671b16608b6c557f2d7d116154171b6bb',
       i686: '0bd8cad70903ea163887184d2bdec1b95f3504c641a40289f9d8582a928e7d9b',
     x86_64: 'f1aabfbc800d64f80a93dd72576b2f24d61270cc738e50da7b1db0e79ba2b541'
  })

  depends_on 'glibc' # R
  depends_on 'jansson'
  depends_on 'jemalloc'
  depends_on 'libev' => :build
  depends_on 'openssl' # R
  depends_on 'python3' => :build
  depends_on 'py3_cython' => :build

  def self.build
    system "mold -run cmake -B builddir -G Ninja #{CREW_CMAKE_OPTIONS} \
      -DENABLE_SHARED_LIB=ON \
      -DENABLE_LIB_ONLY=ON"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
