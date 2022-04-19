require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  @_ver = '3.5'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/parted/parted-#{@_ver}.tar.xz"
  source_sha256 '4938dd5c1c125f6c78b1f4b3e297526f18ee74aa43d45c248578b1d2470c05a2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.5_armv7l/parted-3.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.5_armv7l/parted-3.5-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/parted/3.5_x86_64/parted-3.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd5a0356c1b50d3b96d40816186f53b26230db7642cf2a8efc86e3388c35bdf34',
     armv7l: 'd5a0356c1b50d3b96d40816186f53b26230db7642cf2a8efc86e3388c35bdf34',
     x86_64: '7ff57d716c7c5c5e7a640c57b584bead70e4e853dc0937c501ba95e4a33cfe8a'
  })

  depends_on 'lvm2'
  depends_on 'ncurses'
  depends_on 'readline'
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
