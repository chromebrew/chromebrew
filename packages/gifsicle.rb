require 'package'

class Gifsicle < Package
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.89'
  source_url 'https://github.com/kohler/gifsicle/archive/v1.89.tar.gz'
  source_sha256 '9b19ff8d50d88af5a5151eaf9e62beb1dd5b72002e7b7cc3aec9b385780e6b83'

  def self.build
    system './bootstrap.sh'
    system './configure --without-x --disable-gifview'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
