require 'package'

class Unzip < Package
  description 'UnZip is an extraction utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://www.info-zip.org/UnZip.html'
  version '1.6_1'
  source_url 'https://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz'
  source_sha1 'abf7de8a4018a983590ed6f5cbd990d4740f8a22'
  depends_on 'patch'

  # adapted from the homebrew recipe as seen at: https://github.com/Homebrew/homebrew-dupes/blob/master/unzip.rb
  # Upstream is unmaintained so we use the Ubuntu unzip-6.0-20ubuntu1 patchset:
  # http://changelogs.ubuntu.com/changelogs/pool/main/u/unzip/unzip_6.0-20ubuntu1/changelog
  def self.patch
    patch_url = "https://launchpad.net/ubuntu/+archive/primary/+files/unzip_6.0-20ubuntu1.debian.tar.xz"
    patch_sha256 = "0ddf122ef15b739e3ea06db4b9e80f40759dce23a2c886678881453a43bd0842"

    system('wget', '--continue', '--no-check-certificate', patch_url, '-O', 'unzippatches.tar.xz')
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest( File.read("./unzippatches.tar.xz") ) == patch_sha256
    system("tar","-xf","unzippatches.tar.xz")

    system("for i in `cat debian/patches/series`; do  patch -p 1 < debian/patches/$i; done")
  end

  def self.build
    self.patch
    if ARCH == "armv7l"
      system "make -f unix/Makefile linux_noasm"
    else
      system "make -f unix/Makefile generic"
    end
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "MANDIR=/usr/local/tmp/unzip-man", "-f", "unix/Makefile", "install"
    #remove the man pages we couldn't install
    system "rm -r -f /usr/local/tmp/unzip-man"
  end

end
