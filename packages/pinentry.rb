require 'package'

class Pinentry < Package
  description "A collection of passphrase entry dialogs which is required for almost all usages of GnuPG"
  homepage 'https://gnupg.org/software/pinentry/index.html'
  version '1.0.0'
  source_url 'https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.0.0.tar.bz2'
  source_sha256 '1672c2edc1feb036075b187c0773787b2afd0544f55025c645a71b4c2f79275a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '959808266c3b49c00f333fbdb3b6b5f14ec4abcfb5457091654d8e1254904149',
     armv7l: '959808266c3b49c00f333fbdb3b6b5f14ec4abcfb5457091654d8e1254904149',
       i686: '298c471c2f0ad055aff1c480658b93e7e16fd5e936c7bb6d8b11997018d66f41',
     x86_64: '86d2d87126edcdec32f14592ef74dad9b26d0b683b4699ba4f12452bf2640e19',
  })

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
