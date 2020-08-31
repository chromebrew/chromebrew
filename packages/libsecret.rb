require 'package'

class Libsecret < Package
  description 'GObject based library for accessing the Secret Service API.'
  homepage 'https://github.com/GNOME/libsecret'
  version '0.20.3'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libsecret/archive/0.20.3.tar.gz'
  source_sha256 '9a90f733d4cac1c5a937af1fc44ddfc52458a4bcb015891247ca75037f446f6d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10ef4b1b1c1ba36e61b9322a1fc67b971de4d1db66ed3e47ac7af7e539e8d15b',
     armv7l: '10ef4b1b1c1ba36e61b9322a1fc67b971de4d1db66ed3e47ac7af7e539e8d15b',
       i686: '97f1219df2e796774fb98fb8d37b89731e34b2ab0896df4a560f59e7e05ef216',
     x86_64: '8f0b57c10555bb07c6f869f69bea1c8f4f6ccdedc5175c34506416a2db17343b',
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'libgcrypt' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --buildtype=release -Dgtk_doc=false -Dmanpage=false _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
