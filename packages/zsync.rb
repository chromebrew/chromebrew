require 'package'

class Zsync < Package
  description 'zsync is a client-side file transfer program similar to rsync.'
  homepage 'http://zsync.moria.org.uk/'
  version '0.6.2'
  source_url 'https://zsync.moria.org.uk/download/zsync-0.6.2.tar.bz2'
  source_sha256 '0b9d53433387aa4f04634a6c63a5efa8203070f2298af72a705f9be3dda65af2'

  def self.preinstall
    system "curl -Ls -o autotools/config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "curl -Ls -o autotools/config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
