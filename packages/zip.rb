require 'package'

class Zip < Package
  description 'Zip is a compression and file packaging/archive utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://www.info-zip.org/Zip.html'
  version '3.0-11'
  source_url 'http://downloads.sourceforge.net/project/infozip/Zip%203.x%20%28latest%29/3.0/zip30.tar.gz'
  source_sha256 'f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'compressdoc' => :build
  depends_on 'patch' => :build
  depends_on 'wget' => :build

  # adapted from the homebrew recipe as seen at: https://github.com/Homebrew/homebrew-core/blob/master/Formula/zip.rb
  # Upstream is unmaintained so we use the Debian patchset:
  # https://packages.debian.org/sid/zip
  def self.patch
    patch_url = "https://mirrors.ocf.berkeley.edu/debian/pool/main/z/zip/zip_3.0-11.debian.tar.xz"
    patch_sha256 = "c5c0714a88592f9e02146bfe4a8d26cd9bd97e8d33b1efc8b37784997caa40ed"

    system('wget', '--continue', '--no-check-certificate', patch_url, '-O', 'zippatches.tar.xz')
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest( File.read("./zippatches.tar.xz") ) == patch_sha256
    system("tar","-xf","zippatches.tar.xz")

    system("for i in `cat debian/patches/series`; do  patch -p 1 < debian/patches/$i; done")
  end

  def self.build
    if ARCH == "armv7l"
      system "make -f unix/Makefile linux_noasm"
    else
      system "make -f unix/Makefile generic"
    end
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "BINDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_PREFIX}/share/man/man1", "-f", "unix/Makefile", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end

end
