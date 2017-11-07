require 'package'

class Intltool < Package
  description 'intltool is a set of tools to centralize translation of many different file formats using GNU gettext-compatible PO files.'
  homepage 'https://freedesktop.org/wiki/Software/intltool/'
  version '0.51.0'
  source_url 'https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz'
  source_sha256 '67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd'

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
