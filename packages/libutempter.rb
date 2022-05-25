# Adapted from Arch Linux libutempter PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libutempter/trunk/PKGBUILD

require 'package'

class Libutempter < Package
  description 'Interface for terminal emulators such as screen and xterm to record user sessions to utmp and wtmp files'
  homepage 'http://ftp.altlinux.org/pub/people/ldv/utempter'
  version '1.2.1'
  license 'LGPL'
  compatibility 'all'
  source_url 'http://ftp.altlinux.org/pub/people/ldv/utempter/libutempter-1.2.1.tar.gz'
  source_sha256 '967fef372f391de501843ad87570c6cf5dabd9651f00f1783090fbc12b2a34cb'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libutempter/1.2.1_armv7l/libutempter-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libutempter/1.2.1_armv7l/libutempter-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libutempter/1.2.1_i686/libutempter-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libutempter/1.2.1_x86_64/libutempter-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b770b584f1fbdc24d77c0fd82dcbd6c473926b2c3de234ecce7ef4c76221fe4c',
     armv7l: 'b770b584f1fbdc24d77c0fd82dcbd6c473926b2c3de234ecce7ef4c76221fe4c',
       i686: 'ea4f18fff033f4fe370af032178e72d77b8d6fb072c3f83c884b3c607be9c7ea',
     x86_64: 'ca10f3ea99a63c58fbc07fd6e6d8a16fb34cc18b0110c05bba80bd8b84ce195f'
  })

  depends_on 'glibc'

  def self.patch
    system "sed -i 's,/usr/lib,#{CREW_LIB_PREFIX},g' Makefile"
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' Makefile"
    system "sed -i 's,/usr/share/man,#{CREW_MAN_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
