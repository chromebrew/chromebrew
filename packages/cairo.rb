require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org/'
  version '1.14.8'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.8.tar.xz'
  source_sha1 'c6f7b99986f93c9df78653c3e6a3b5043f65145e'

  depends_on 'libpng'
  depends_on 'pixman'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
