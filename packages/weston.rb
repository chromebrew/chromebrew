require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  version '4.0.0-1'
  source_url 'https://github.com/wayland-project/weston/archive/4.0.0.tar.gz'
  source_sha256 '46b0178cd37b0bf7471c9af12c847c7b8728699ecd5c04ce79be77ea12c98512'

  depends_on 'harfbuzz'
  depends_on 'libxcursor'
  depends_on 'libinput'
  depends_on 'libxkbcommon'
  depends_on 'wayland_protocols'
  depends_on 'libjpeg'
  depends_on 'libwebp'
  depends_on 'libunwind'
    
  depends_on 'pango'
  depends_on 'dbus'
  
  depends_on 'libxxf86vm'

  def self.build
    system "./autogen.sh"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-weston-launch",
           "--enable-demo-clients-install"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.postinstall
    system "libtool --finish #{CREW_LIB_PREFIX}/weston"
    system "chmod 700 $XDG_RUNTIME_DIR -v"
  end
end
