require 'package'

class Libnxml < Package
  description 'libnXML is a C library for parsing, writing and creating XML 1.0 and 1.1 files or streams.'
  homepage 'https://www.autistici.org/bakunin/libnxml/doc/'
  version '0.18.3-8'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/libnxml/-/archive/debian/0.18.3-8/libnxml-debian-0.18.3-8.tar.bz2'
  source_sha256 '2c3e910b591d8f2a4dde53874339ddf831cfcce4cfece429217b5a5b9f850a9d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnxml/0.18.3-8_armv7l/libnxml-0.18.3-8-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnxml/0.18.3-8_armv7l/libnxml-0.18.3-8-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnxml/0.18.3-8_i686/libnxml-0.18.3-8-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnxml/0.18.3-8_x86_64/libnxml-0.18.3-8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '09813321479882310b5bedd48909ec6dcdc47e7f6970d79c692bbdcb2ed88c77',
     armv7l: '09813321479882310b5bedd48909ec6dcdc47e7f6970d79c692bbdcb2ed88c77',
       i686: 'f6cd8aa96121ca5bf8b842e20dac82f058b95d4885562b3d1030c0f11036bc6b',
     x86_64: '8033e7df4c76b159f21d467bff92be81b3f7fdaaef5fb31d5a1c232c641f651c'
  })

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
  end

  def self.prebuild
    FileUtils.chmod 0o755, './configure'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
