require 'package'

class Zsync < Package
  description 'zsync is a client-side file transfer program similar to rsync.'
  homepage 'http://zsync.moria.org.uk/'
  version '0.6.2'
  compatibility 'all'
  source_url 'https://zsync.moria.org.uk/download/zsync-0.6.2.tar.bz2'
  source_sha256 '0b9d53433387aa4f04634a6c63a5efa8203070f2298af72a705f9be3dda65af2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zsync-0.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zsync-0.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zsync-0.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zsync-0.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec99187285ee26098f60a08e075e61fe7ea2b66b153052c3be9aac8866c39d77',
     armv7l: 'ec99187285ee26098f60a08e075e61fe7ea2b66b153052c3be9aac8866c39d77',
       i686: 'fd3630d2edcdac1730de54d82674505a1b98c2430e3fb04224147348175bbc69',
     x86_64: 'ce5a3c89fec4f13638ade49db7c2c45ca169e86b34687b3c55710f534789aba6',
  })

  def self.patch
    system "curl -Ls -o autotools/config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o autotools/config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
