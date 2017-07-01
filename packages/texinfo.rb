require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.3'
  source_url 'http://ftp.gnu.org/gnu/texinfo/texinfo-6.3.tar.gz'
  source_sha256 '300a6ba4958c2dd4a6d5ce60f0a335daf7e379f5374f276f6ba31a221f02f606'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
