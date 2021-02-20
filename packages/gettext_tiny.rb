require 'package'

class Gettext_tiny < Package
  description 'gettext-tiny provides lightweight replacements for tools typically used from the GNU gettext suite.'
  homepage 'https://github.com/sabotage-linux/gettext-tiny'
  version '0.3.2'
  compatibility 'all'
  source_url 'https://ftp.barfooze.de/pub/sabotage/tarballs/gettext-tiny-0.3.2.tar.xz'
  source_sha256 'a9a72cfa21853f7d249592a3c6f6d36f5117028e24573d092f9184ab72bbe187'

  def self.preinstall
    abort "gettext already installed. gettext_tiny conflicts with gettext.".lightred if File.exist? "#{CREW_PREFIX}/bin/msgcomm"
  end

  def self.build
    system "make", "LIBINTL=NONE"
  end

  def self.install
    system "make", "LIBINTL=NONE", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", "install"
  end
end
