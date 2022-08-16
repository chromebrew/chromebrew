# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'package'

class Protobuf < Package
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://developers.google.com/protocol-buffers/'
  @_ver = '21.5'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/protocolbuffers/protobuf/archive/v#{@_ver}/protobuf-#{@_ver}.tar.gz"
  source_sha256 '4a7e87e4166c358c63342dddcde6312faee06ea9d5bb4e2fa87d3478076f6639'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf/21.5_armv7l/protobuf-21.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf/21.5_armv7l/protobuf-21.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf/21.5_i686/protobuf-21.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf/21.5_x86_64/protobuf-21.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '385f997ea44f29e57e3f09ac287e5c0916bc00bbcb37ec72c7546acbfcdaebec',
     armv7l: '385f997ea44f29e57e3f09ac287e5c0916bc00bbcb37ec72c7546acbfcdaebec',
       i686: '1381f344f2d10146615dc8d9344841c3df814ba6bf1701c5edcc37d5d53c840b',
     x86_64: 'b5f2199cdf7ed7232475c6b745abc0a3df6e8e3a042bf19ed79fd50feaf535c3'
  })

  depends_on 'zlibpkg'
  depends_on 'python3' => :build
  depends_on 'cmake' => :build

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
