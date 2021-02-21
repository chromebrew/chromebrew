require 'package'

class Zip < Package
  description 'Zip is a compression and file packaging/archive utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://www.info-zip.org/Zip.html'
  version '3.0-11'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/infozip/Zip%203.x%20%28latest%29/3.0/zip30.tar.gz'
  source_sha256 'f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zip-3.0-11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zip-3.0-11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zip-3.0-11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zip-3.0-11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1905c224b2b73e81c3622c3f440540953bff6516d514addd1f1e09a75573d34b',
     armv7l: '1905c224b2b73e81c3622c3f440540953bff6516d514addd1f1e09a75573d34b',
       i686: '58535613e27ac7494cdfbae25d61c4971ee1d670816169a52eec79df3645e21d',
     x86_64: 'c78a63d3630f3dbf637127e1a5a08942fd1da213cde296d33e77823e8547a56c',
  })

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

    system("for i in `cat debian/patches/series`; do patch -p 1 < debian/patches/$i; done")
  end

  def self.build
    system 'make -f unix/Makefile generic'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "BINDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_MAN_PREFIX}/man1", '-f', 'unix/Makefile', 'install'
  end
end
