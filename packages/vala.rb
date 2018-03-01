require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.39.7'
  source_url 'https://download.gnome.org/sources/vala/0.39/vala-0.39.7.tar.xz'
  source_sha256 'a54ec96125fdb63dbf96a8a3a65df41fdd88a617c1354088b5e10f8f0c89914d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.39.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.39.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.39.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.39.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d8eb6026b3f61f5ec7d53f9fd62128b1458e3f6a1f99a0945d02bb98704b87a',
     armv7l: '1d8eb6026b3f61f5ec7d53f9fd62128b1458e3f6a1f99a0945d02bb98704b87a',
       i686: 'ff2aec0b381ecd54bd5fb043b1c4d7bfd0810665dea570ba3b3ff9683cbfb2c9',
     x86_64: '798c51833e5110b45003a1efd2f3b6cf60dfc26f9c3f7d7158b3a1185d7a8f82',
  })

  depends_on 'flex'
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
