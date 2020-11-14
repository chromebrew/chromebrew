require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  version '9.0.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/wayland-project/weston/archive/9.0.0.tar.gz'
    source_sha256 '82b17ab1766f13557fc620c21e3c89165342d3a3ead79ba01181b4f7d2144487'

    depends_on 'harfbuzz'
    depends_on 'libxcursor'
    depends_on 'libinput'
    depends_on 'libxkbcommon'
    depends_on 'wayland_protocols'
    depends_on 'libjpeg'
    depends_on 'libunwind'
    depends_on 'pango'
    depends_on 'dbus'
    depends_on 'libxxf86vm'
    depends_on 'llvm' => :build
    depends_on 'xdg_base'
  end


  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson #{CREW_MESON_OPTIONS} -Dshell-ivi=false -Dremoting=false -Dbackend-default=wayland -Dbackend-drm=false -Dpipewire=false -Dcolor-management-colord=false -Dcolor-management-lcms=false -Dbackend-rdp=false -Dlauncher-logind=false -Dweston-launch=false -Dsystemd=false -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland build"
    system "meson configure build"
    system 'ninja -C build'
    system "cat <<'EOF'> weston.ini
[core]
xwayland=true

[terminal]
font=Cousine
EOF"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C build"
    system "install -Dm644 weston.ini #{CREW_DEST_HOME}/.config/weston.ini"
  end
  
  def self.postinstall
    puts "To run weston with xwayland try something like this:".lightred
    puts "export WAYLAND_DISPLAY=wayland-1".lightred
    puts "WAYLAND_DISPLAY=wayland-0 weston -Swayland-1 --xwayland".lightred
  end
end
