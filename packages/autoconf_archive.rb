require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2017-09-28'
  source_url 'https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2017.09.28.tar.xz'
  source_sha256 '5c9fb5845b38b28982a3ef12836f76b35f46799ef4a2e46b48e2bd3c6182fa01'

  binary_url ({
  })
  binary_sha256 ({
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
