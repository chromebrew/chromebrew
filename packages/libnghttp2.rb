require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.43.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/nghttp2/nghttp2/releases/download/v#{@_ver}/nghttp2-#{@_ver}.tar.bz2"
  source_sha256 '556f24653397c71ebb8270b3c5e5507f0893e6eac2c6eeda6be2ecf6e1f50f62'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.43.0-1_armv7l/libnghttp2-1.43.0-1-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.43.0-1_armv7l/libnghttp2-1.43.0-1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.43.0-1_i686/libnghttp2-1.43.0-1-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnghttp2/1.43.0-1_x86_64/libnghttp2-1.43.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '022e8875b50308e626209a76df03a67e57a904c6932e1bb1c52018c3eb763cbc',
    armv7l: '022e8875b50308e626209a76df03a67e57a904c6932e1bb1c52018c3eb763cbc',
    i686: '2ea5d7dba201696ff274937e47b8a7eb1d202be529d6c20be23a9ea4156e76a8',
    x86_64: '497555f7091679fb5993479a48aabf18704e098269b2d91ba34ef0d592e65b7f'
  })

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DENABLE_SHARED_LIB=ON \
      -DENABLE_STATIC_LIB=ON \
      ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
