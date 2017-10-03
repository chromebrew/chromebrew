require 'package'

class Pinentry < Package
  description "A collection of passphrase entry dialogs which is required for almost all usages of GnuPG"
  homepage 'https://gnupg.org/software/pinentry/index.html'
  version '1.0.0'
  source_url 'https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.0.0.tar.bz2'
  source_sha256 '1672c2edc1feb036075b187c0773787b2afd0544f55025c645a71b4c2f79275a'

  depends_on 'gnupg'
  depends_on 'libcap'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
