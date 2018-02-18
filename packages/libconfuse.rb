require 'package'

class Libconfuse < Package
  description 'Small configuration file parser library for C.'
  homepage 'https://github.com/martinh/libconfuse'
  version '3.2.1'
  source_url 'https://github.com/martinh/libconfuse/releases/download/v3.2.1/confuse-3.2.1.tar.xz'
  source_sha256 '23c63272baf2ef4e2cbbafad2cf57de7eb81f006ec347c00b954819824add25e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'apriconv'
  depends_on 'intltool'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
