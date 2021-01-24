require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.18.0-2'
  compatibility 'all'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.18.0.tar.xz'
  source_sha256 '4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d'

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libffi'
  depends_on 'libxml2'
  depends_on 'libxslt'
  #depends_on 'xmlto' => :build
  #depends_on 'docbook_xsl' => :build
  #depends_on 'graphviz' => :build # GraphViz doesn't have PNG support enabled

  def self.build
    system "./configure \
            #{CREW_OPTIONS} \
            --disable-documentation"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'libtool', '--finish', CREW_LIB_PREFIX
  end
end
