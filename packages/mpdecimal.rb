# Adapted from Arch Linux mpdecimal PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/mpdecimal/trunk/PKGBUILD

require 'package'

class Mpdecimal < Package
  description 'Package for correctly-rounded arbitrary precision decimal floating point arithmetic'
  homepage 'https://www.bytereef.org/mpdecimal/index.html'
  version '2.5.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-2.5.1.tar.gz'
  source_sha256 '9f9cd4c041f99b5c49ffb7b59d9f12d95b683d88585608aa56a6307667b2b21f'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpdecimal/2.5.1_armv7l/mpdecimal-2.5.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpdecimal/2.5.1_armv7l/mpdecimal-2.5.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpdecimal/2.5.1_i686/mpdecimal-2.5.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpdecimal/2.5.1_x86_64/mpdecimal-2.5.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e995ff521db72f576566f4b7b9d9a5e4474be854a4e9d5177872b2185dc4ccbe',
     armv7l: 'e995ff521db72f576566f4b7b9d9a5e4474be854a4e9d5177872b2185dc4ccbe',
       i686: '683d89e09f6826a1ee6c70cdafa00e5fbd5fe6cc472b8141afb8f6dd989aba9d',
     x86_64: '9eeeca2110c6be8a862f76d81910e070b60502d3542cc24842422b771b5292fd'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
