require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  version '3.0.91-0'
  source_url 'https://github.com/wayland-project/weston/archive/3.0.91.tar.gz'
  source_sha256 'a27eecd9dd9a18131292d33eba37f35369ede5f3b0688154244e3238b27f854a'

    depends_on 'harfbuzz'
    depends_on 'libxcursor'
    depends_on 'libinput'
    depends_on 'libxkbcommon'
    depends_on 'wayland_protocols'
    depends_on 'libjpeg'
    depends_on 'libunwind'
    
    depends_on 'pango'
    depends_on 'dbus'

    
  def self.build
      system "./autogen.sh"  
      system "./configure \
              --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              --disable-lcms \
              --disable-systemd-notify \
              --disable-weston-launch"    
      system "make"
  end

  def self.install
      system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
