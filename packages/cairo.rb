require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org/'
  version '1.14.8'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.8.tar.xz'
  source_sha256 'd1f2d98ae9a4111564f6de4e013d639cf77155baf2556582295a0f00a9bc5e20'

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
