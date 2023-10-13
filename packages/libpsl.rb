require 'package'

class Libpsl < Package
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  @_ver = '0.21.1'
  version "#{@_ver}-3"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/rockdaboot/libpsl/releases/download/#{@_ver}/libpsl-#{@_ver}.tar.lz"
  source_sha256 '644375d557bb3b84c485df2dae98ee388fe1e11fb75230004e4b8623b3b833a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-3_armv7l/libpsl-0.21.1-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-3_armv7l/libpsl-0.21.1-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-3_i686/libpsl-0.21.1-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-3_x86_64/libpsl-0.21.1-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f35e2a5509eece1e4117aaa558ca3d50bd3e5015bc1781ade88ed173210142fc',
     armv7l: 'f35e2a5509eece1e4117aaa558ca3d50bd3e5015bc1781ade88ed173210142fc',
       i686: 'ee55698080997b2d65c26dc3fccf1fdde660d76c52fdd3ed8498064a88b91a71',
     x86_64: '65be38748baca2f4bf9cf689b9894ce62dc37d909e2545a27a9612ec9fb8d419'
  })

  depends_on 'glibc' # R
  depends_on 'libidn2'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
