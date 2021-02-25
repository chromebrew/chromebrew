require 'package'

class Dconf < Package
  description 'The DConf package contains a low-level configuration system.'
  homepage 'https://wiki.gnome.org/Projects/dconf'
  version '0.39.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.beta/sources/dconf-0.39.1.tar.xz'
  source_sha256 '9a3870bf07b8e0452e22ce068d51c7f19c1e1cfeacd9883c03523822afdff665'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.39.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.39.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.39.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.39.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a6bc274c2a1bc39ac0ee01e9b6d1121378a7c3e5a7abf3c60c3762248f504888',
     armv7l: 'a6bc274c2a1bc39ac0ee01e9b6d1121378a7c3e5a7abf3c60c3762248f504888',
       i686: 'b640f46b95ca5286068c640e6969278e85d6c5e96277b9bcd9510f9d59df8be1',
     x86_64: '3073982a22ecba46620ef73aae362e8925019d075260fb0cbc9ce0a64463dc6e'
  })

  depends_on 'dbus' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib'  # version 2
  depends_on 'vala' => :build
  depends_on 'bash_completion' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
