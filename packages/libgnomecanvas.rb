require 'package'

class Libgnomecanvas < Package
  description 'The GnomeCanvas widget provides a flexible widget for creating interactive structured graphics.'
  homepage 'https://developer.gnome.org/libgnomecanvas/'
  version '2.30.3'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libgnomecanvas/2.30/libgnomecanvas-2.30.3.tar.bz2'
  source_sha256 '859b78e08489fce4d5c15c676fec1cd79782f115f516e8ad8bed6abcb8dedd40'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '28f2d716908db225ed00e2df39a99dd8947710b42fb03c6feec74bffabc28d6f',
     armv7l: '28f2d716908db225ed00e2df39a99dd8947710b42fb03c6feec74bffabc28d6f',
     x86_64: '07a6f6ece37d04b4fccc1c817b8f7845cbc6443f6868be5d8ed1f84b8951268a'
  })

  depends_on 'libart'
  depends_on 'libglade'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-glade'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
