require 'package'

class Libmbim < Package
  description 'libmbim is a glib-based library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model (MBIM) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libmbim/'
  version '1.16.2'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/libmbim/libmbim-1.16.2.tar.xz'
  source_sha256 'eb494fee2c200daf4f5cc8a40061d24a3dfafe8c59151c95c6a826fd96dcb262'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmbim-1.16.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmbim-1.16.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmbim-1.16.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmbim-1.16.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '20e7289ee6494836d2ae1ae555fcd8dcdaaaf17fbd4c60036d0729b548885007',
     armv7l: '20e7289ee6494836d2ae1ae555fcd8dcdaaaf17fbd4c60036d0729b548885007',
       i686: 'f05206366153c334dacc0320633b8dcb2b4ef331a2ac99d710084a7a19b52f2f',
     x86_64: '8e85d643f339222cede9361db492333709a4c5e0f135aff659c996d51020abff',
  })

  depends_on 'glib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
