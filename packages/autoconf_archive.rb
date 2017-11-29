require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2017-09-28'
  source_url 'https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2017.09.28.tar.xz'
  source_sha256 '5c9fb5845b38b28982a3ef12836f76b35f46799ef4a2e46b48e2bd3c6182fa01'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2017-09-28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2017-09-28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2017-09-28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2017-09-28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cdbfd6f1144c089e4d6080e8a0e157e7275c9b47b223c2b945d20728710ecbc7',
     armv7l: 'cdbfd6f1144c089e4d6080e8a0e157e7275c9b47b223c2b945d20728710ecbc7',
       i686: 'cd49caa68b93a49cc235ccc6cdc5ab8c4ce4266bd9b5c197be7c3eceb727ed72',
     x86_64: '7e7e915959f3c835a6417628737c8cde91e39c32842da8571e7484110e55bff4',
  })

  depends_on 'perl'
  depends_on 'm4'
  depends_on 'autoconf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
