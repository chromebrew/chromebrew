require 'package'

class Libpsl < Package
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  @_ver = '0.21.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/rockdaboot/libpsl/releases/download/#{@_ver}/libpsl-#{@_ver}.tar.lz"
  source_sha256 '644375d557bb3b84c485df2dae98ee388fe1e11fb75230004e4b8623b3b833a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-1_armv7l/libpsl-0.21.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-1_armv7l/libpsl-0.21.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-1_i686/libpsl-0.21.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-1_x86_64/libpsl-0.21.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '820d6bd20a1981c33a9d3a998d6d10660dda64124405ea0ca04f3cc485d35e00',
     armv7l: '820d6bd20a1981c33a9d3a998d6d10660dda64124405ea0ca04f3cc485d35e00',
       i686: '38032e35bd8c942a88ee0f911627b41b2e13f5cbc349827127582830fe4d21c8',
     x86_64: 'e0e147b462d7a1d8a585ca205d6386263fdf7aa59b3b36aaaa3ee528fabf99c2'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_ENV_OPTIONS} #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
