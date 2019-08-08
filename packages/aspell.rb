require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.7-1'
  source_url 'ftp://ftp.gnu.org/gnu/aspell/aspell-0.60.7.tar.gz'
  source_sha256 '5ca8fc8cb0370cc6c9eb5b64c6d1bc5d57b3750dbf17887726c3407d833b70e4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ruby' unless File.exists? "#{CREW_PREFIX}/bin/ruby"
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
