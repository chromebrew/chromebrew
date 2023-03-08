# Adapted from Arch Linux tevent PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/tevent/trunk/PKGBUILD

require 'package'

class Tevent < Package
  description 'Event system based on the talloc memory management library'
  homepage 'https://tevent.samba.org/'
  @_ver = '0.14.1'
  version "#{@_ver}-py3.11"
  license 'LGPL'
  compatibility 'all'
  source_url "https://samba.org/ftp/tevent/tevent-#{@_ver}.tar.gz"
  source_sha256 'ef85fcaa80ffd2351036ba4b347630fef2a1ac3da964a7f1820466bad03cd00d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.14.1-py3.11_armv7l/tevent-0.14.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.14.1-py3.11_armv7l/tevent-0.14.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.14.1-py3.11_i686/tevent-0.14.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tevent/0.14.1-py3.11_x86_64/tevent-0.14.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '345bde4110b93f90d8d71109dd28e599dd23bb665c652ed3e6d743c7980b6cca',
     armv7l: '345bde4110b93f90d8d71109dd28e599dd23bb665c652ed3e6d743c7980b6cca',
       i686: 'e7483ab95644fb71d5fea6a4b97813b7d30edc470295bcfcdb6754b7734e5413',
     x86_64: '9670ae6cdf285b38902cf8b552698266d514b1ed4627d6e1df2bc0358ee11b73'
  })

  depends_on 'cmocka' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'python3' => :build
  depends_on 'talloc' # R

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
