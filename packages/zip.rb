require 'package'

class Zip < Package
  description 'Zip is a compression and file packaging/archive utility for archives compressed in .zip format (also called \'zipfiles\').'
  homepage 'http://www.info-zip.org/Zip.html'
  version '3.0-15'
  license 'Info-ZIP'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/infozip/Zip%203.x%20%28latest%29/3.0/zip30.tar.gz'
  source_sha256 'f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37f4831a8d4833374557f9501987305a8c1f021c11b96586bc2f0042ff637805',
     armv7l: '37f4831a8d4833374557f9501987305a8c1f021c11b96586bc2f0042ff637805',
       i686: '2769c0ca885a8ca686ade489f01f5d0004d1d13a0e1f7a284137c5067d54f7e1',
     x86_64: '1f92ba515b9d847196d1f1434a5b418b2e86d2c9205f13b4b925764276e557a6'
  })

  depends_on 'bzip2' # R
  depends_on 'glibc' => :executable_only

  # adapted from the homebrew recipe as seen at: https://github.com/Homebrew/homebrew-core/blob/master/Formula/zip.rb
  # Upstream is unmaintained so we use the Debian patchset:
  # https://packages.debian.org/sid/zip
  def self.patch
    downloader "https://mirrors.ocf.berkeley.edu/debian/pool/main/z/zip/zip_#{version}.debian.tar.xz", '6dc1711c67640e8d1dee867ff53e84387ddb980c40885bd088ac98c330bffce9'
    system('tar', '-xf', "zip_#{version}.debian.tar.xz")

    system('for i in `cat debian/patches/series`; do patch -p 1 < debian/patches/$i; done')
  end

  def self.build
    system 'make -f unix/Makefile generic'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "BINDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_MAN_PREFIX}/man1", '-f', 'unix/Makefile', 'install'
  end
end
