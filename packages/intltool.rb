require 'package'

class Intltool < Package
  description 'intltool is a set of tools to centralize translation of many different file formats using GNU gettext-compatible PO files.'
  homepage 'https://freedesktop.org/wiki/Software/intltool/'
  version '0.51.0'
  source_url 'https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz'
  source_sha256 '67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/intltool-0.51.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9dde9cb290ede337fbb4017d492ed623f58bec9703657ad95210beb2ae402e91',
     armv7l: '9dde9cb290ede337fbb4017d492ed623f58bec9703657ad95210beb2ae402e91',
       i686: 'f2177c902c6bc94da49ec78c436f01d99abc68e35650228ac9835f789d123c66',
     x86_64: 'e6a6069282bf20d1fdd70b6619a839bcbd8a311ac840eed36418a143515e291e',
  })

  depends_on 'libtool'
  depends_on 'perl_xml_parser'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
