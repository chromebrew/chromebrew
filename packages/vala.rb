require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.46.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/vala/0.46/vala-0.46.2.tar.xz'
  source_sha256 '92070393e8102da29e07b29fcb808d021600a25f8a2a69c852470ec8d97740bc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.46.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.46.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.46.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.46.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd4a5d86362e56157ea7001c83ab72a50ca937fd6bc20ec00bec2a9c0e826d7ae',
     armv7l: 'd4a5d86362e56157ea7001c83ab72a50ca937fd6bc20ec00bec2a9c0e826d7ae',
       i686: 'd13f33f14060fc3b4303652ea47b5a40cfd2ac85f01a6e902b6994917165e9e9',
     x86_64: '57e4dcf97d1a6385458482ebf6d491d8fbdc06297e644046bbe83c109987215e',
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
