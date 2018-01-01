require 'package'

class Gifsicle < Package
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.90'
  source_url 'https://github.com/kohler/gifsicle/archive/v1.90.tar.gz'
  source_sha256 'eb0f4bf3527a1befd0d8ef9e12a6048536adee4705e91ff4bdb3ea7364007e14'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './bootstrap.sh'
    system './configure --without-x --disable-gifview'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
