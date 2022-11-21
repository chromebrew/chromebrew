# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'package'

class Hwdata < Package
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.364'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hwdata/0.364_armv7l/hwdata-0.364-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hwdata/0.364_armv7l/hwdata-0.364-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hwdata/0.364_i686/hwdata-0.364-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hwdata/0.364_x86_64/hwdata-0.364-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '83a4154f919d109742b2dda111ce6ef08afc5f43c5d839a093db10d30ba55b97',
     armv7l: '83a4154f919d109742b2dda111ce6ef08afc5f43c5d839a093db10d30ba55b97',
       i686: 'ead76070d35543ebbe770e8d69671cdb069483010e2f798d94fc8f840baa9cca',
     x86_64: 'f3d6e7550fdff0bb6ef8341d93cc5cb377d1134568e12a1e3c42cb1aee36d6c1'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --datadir=#{CREW_PREFIX}/share"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    # Do not package blacklist of kernel modules
    FileUtils.rm_rf CREW_DEST_LIB_PREFIX
  end
end
