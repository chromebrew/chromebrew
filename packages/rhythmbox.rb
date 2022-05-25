require 'package'

class Rhythmbox < Package
  description 'Rhythmbox is a music playing application for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Rhythmbox'
  version '3.4.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://download.gnome.org/sources/rhythmbox/3.4/rhythmbox-3.4.4.tar.xz'
  source_sha256 'ee0eb0d7d7bdf696ac9471b19ff3bea3240d63b6cb8a134bf632054af8665d90'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rhythmbox/3.4.4_armv7l/rhythmbox-3.4.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rhythmbox/3.4.4_armv7l/rhythmbox-3.4.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rhythmbox/3.4.4_x86_64/rhythmbox-3.4.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '678900ce7386040ee771131b633252a873c78f3e65d028a0bc89e52ab25960b3',
     armv7l: '678900ce7386040ee771131b633252a873c78f3e65d028a0bc89e52ab25960b3',
     x86_64: '36c0657e604a4692c3a5a672e4f45b64ce3b275a58116e72269f68cb68677b63'
  })

  depends_on 'gtk3'
  depends_on 'gst_plugins_base'
  depends_on 'libpeas'
  depends_on 'totem_pl_parser'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts "\nType 'rhythmbox' to get started.\n".lightblue
  end
end
