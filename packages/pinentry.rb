require 'package'

class Pinentry < Package
  description "A collection of passphrase entry dialogs which is required for almost all usages of GnuPG"
  homepage 'https://gnupg.org/software/pinentry/index.html'
  version '1.1.0-1'
  compatibility 'all'
  source_url 'https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.0.tar.bz2'
  source_sha256 '68076686fa724a290ea49cdf0d1c0c1500907d1b759a3bcbfbec0293e8f56570'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pinentry-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6b0d4c5f8806b54a00ff932b9d77183e14e16fc9d78e90018b4444591eaf1ff0',
     armv7l: '6b0d4c5f8806b54a00ff932b9d77183e14e16fc9d78e90018b4444591eaf1ff0',
       i686: '759683fb43d0936de9aed52c8b95de5083f85d2181619952c188cba12fcd1d5e',
     x86_64: 'e9af08a3fcb09f6001c39438976c4be453fea946775391fbcaedd03d2700869a',
  })

  depends_on 'libcap'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
