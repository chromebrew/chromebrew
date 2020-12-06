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

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/weston-9.0.0-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weston-9.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '8c685a9d0ae049ed457b32a5513aeb170496fe6c534542d4742092cc62673da4',
    x86_64: '3f391f699eb4e4da0cbb54865d21cf828850889403ad0e99f1065d382ab97f71',
  })

  def self.build
    ENV['CFLAGS'] = '-fuse-ld=lld'
    ENV['CXXFLAGS'] = '-fuse-ld=lld'
    system "meson #{CREW_MESON_OPTIONS} -Dshell-ivi=false -Dremoting=false -Dbackend-default=wayland -Dbackend-drm=false -Dpipewire=false -Dcolor-management-colord=false -Dcolor-management-lcms=false -Dbackend-rdp=false -Dlauncher-logind=false -Dweston-launch=false -Dsystemd=false -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland build"
    system 'meson configure build'
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
    puts
    puts "To run weston with xwayland try something like this:".lightblue
    puts "export WAYLAND_DISPLAY=wayland-1".lightblue
    puts "WAYLAND_DISPLAY=wayland-0 weston -Swayland-1 --xwayland".lightblue
    puts
  end
end
