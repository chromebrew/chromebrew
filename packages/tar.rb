require 'package'

class Tar < Package
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.34'
  license 'BSD'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/tar/tar-1.34.tar.xz'
  source_sha256 '63bebd26879c5e1eea4352f0d03c991f966aeb3ddeb3c7445c902568d5411d28'

  

  def self.build
    system "./configure #{CREW_OPTIONS} --with-lzma=xz"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
