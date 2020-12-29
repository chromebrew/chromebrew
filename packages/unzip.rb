require 'package'

class Unzip < Package
  description 'UnZip is an extraction utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://www.info-zip.org/UnZip.html'
  version '6.0-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz'
  source_sha256 '036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unzip-6.0-2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unzip-6.0-2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/unzip-6.0-2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unzip-6.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '116ed2b03bcaeaa7ccd339e58b67519361933490d1469a72b3c9e12808fc4797',
      armv7l: '116ed2b03bcaeaa7ccd339e58b67519361933490d1469a72b3c9e12808fc4797',
        i686: '488891584f8cf53bcd3969140ab0baffeec4cffb4964c6b836d745afd17a86fe',
      x86_64: 'a58e8a34a46721674ba16198fa943297c6fa80c5933b956bd1ebb6fe91ac6b89',
  })

  depends_on 'compressdoc' => :build
  depends_on 'patch' => :build

  # adapted from the homebrew recipe as seen at: https://github.com/Homebrew/homebrew-dupes/blob/master/unzip.rb
  # Upstream is unmaintained so we use the Ubuntu unzip_6.0-25ubuntu1 patchset:
  # https://changelogs.ubuntu.com/changelogs/pool/main/u/unzip/unzip_6.0-25ubuntu1/changelog
  def self.patch
    patch_url = "http://archive.ubuntu.com/ubuntu/pool/main/u/unzip/unzip_6.0-25ubuntu1.debian.tar.xz"
    patch_sha256 = '6a22b0d23cf8b9e1a74626d7d9af5efe1257e157f20006272dc68693a13f3b45'

    system('wget', '--continue', '--no-check-certificate', patch_url, '-O', 'unzippatches.tar.xz')
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest( File.read("./unzippatches.tar.xz") ) == patch_sha256
    system("tar","-xf","unzippatches.tar.xz")

    system("for i in `cat debian/patches/series`; do  patch -p 1 < debian/patches/$i; done")
  end

  def self.build
    # LCHMOD is not supported in linux.
    system 'echo "CFLAGS=-DNO_LCHMOD" >> flags'
    system "make -f unix/Makefile generic"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "BINDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_PREFIX}/share/man/man1", "-f", "unix/Makefile", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end

end
