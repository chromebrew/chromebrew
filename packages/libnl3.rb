require 'package'

class Libnl3 < Package
  description 'libnl is a library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  @_ver = '3.5.0'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/thom311/libnl.git'
  git_hashtag "libnl#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.5.0_armv7l/libnl3-3.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.5.0_armv7l/libnl3-3.5.0-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.5.0_i686/libnl3-3.5.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnl3/3.5.0_x86_64/libnl3-3.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '265fb9c115d3d00aaa06c88d01a817467aa70cc0d4fd3e8ea62d08d22f3870cd',
     armv7l: '265fb9c115d3d00aaa06c88d01a817467aa70cc0d4fd3e8ea62d08d22f3870cd',
    i686: '9fe4afdea1bac12e037d95c904e9992ee07d05fdeebff33d1a0b995863611d01',
  x86_64: '56ac30c301373e04884d53be9fcbdca2370868724dc870282ac15d11dfca1c93'
  })

  def self.build
    system 'autoupdate'
    system './autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-cli \
              --enable-pthreads \
              --disable-debug"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
