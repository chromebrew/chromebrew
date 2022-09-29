require 'package'

class Libpsl < Package
  description 'C library for the Public Suffix List'
  homepage 'https://github.com/rockdaboot/libpsl'
  @_ver = '0.21.1'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/rockdaboot/libpsl/releases/download/#{@_ver}/libpsl-#{@_ver}.tar.lz"
  source_sha256 '644375d557bb3b84c485df2dae98ee388fe1e11fb75230004e4b8623b3b833a9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-2_armv7l/libpsl-0.21.1-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-2_armv7l/libpsl-0.21.1-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-2_i686/libpsl-0.21.1-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpsl/0.21.1-2_x86_64/libpsl-0.21.1-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd3ceed9e1804466bc69c4850385353b2cc149c3c2e391726afef1791af4934ef',
     armv7l: 'd3ceed9e1804466bc69c4850385353b2cc149c3c2e391726afef1791af4934ef',
       i686: '8d06b3c1b028b6abab13f0c77d1e36903781d20e68b80709b09f2fd0fa0ac945',
     x86_64: '36a20069519346782dad64a36cdb1628de2dcbf01320399ee6c088c18fd86b3f'
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
