require 'package'

class Xclip < Package
  description 'Provides an interface to X selections ("the clipboard") from the command line.'
  homepage 'https://github.com/astrand/xclip'
  version '0.13'
  compatibility 'all'
  source_url 'https://github.com/astrand/xclip/archive/0.13.tar.gz'
  source_sha256 'ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758'

  depends_on 'libx11'
  depends_on 'imake' => :build

  def self.build
    system "./bootstrap"
    system "./configure #{CREW_OPTIONS} \
            --with-x"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
