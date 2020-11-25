require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  version '1.20.9-1'
  compatibility 'all'
  # Using xorg ToT due to large number of recent xwayland commits.
  source_url 'https://github.com/freedesktop/xorg-xserver/archive/d18dcecbe08a9ff22e43f12b6b7679a6ef1a6eb0.zip'
  source_sha256 '091edf47059adfa09242906db97e1d9d44dc6557efde4af861a7055975fa55ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.9-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.9-1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xwayland-1.20.9-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '09a2f25dadcdf4d04bd7939daccef4286540dc17da05f96dd27001d5e29e64bd',
     armv7l: '09a2f25dadcdf4d04bd7939daccef4286540dc17da05f96dd27001d5e29e64bd',
     x86_64: '5d88e6eead59c165464489aee67fa8a28005ec2e407d5d3e042bde27beeb1c9a',
  })
  
  depends_on 'libepoxy'
  depends_on 'xorg_proto'
  depends_on 'libxtrans'
  depends_on 'libxkbfile'
  depends_on 'wayland'
  depends_on 'eudev'
  depends_on 'libxfont'
  depends_on 'libbsd'
  depends_on 'nettle'
  depends_on 'libtirpc'
  depends_on 'pixman'
  depends_on 'xinit'
  depends_on 'libxkbcommon'
  depends_on 'libunwind'
  depends_on 'font_util'
  depends_on 'xorg_lib'
  depends_on 'libtirpc'
  depends_on 'font_util'
  depends_on 'libbsd'
  depends_on 'dbus'
  depends_on 'lzma' => :build
  depends_on 'xkbcomp'
  depends_on 'glproto'
  depends_on 'mesa'

  # Patches are from Google xwayland overlay at https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/chromiumos-overlay/x11-base/xwayland/files/
  def self.patch
    url_patch1 = "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/067ac4b5060c16e6687a97cbb4bcdbaf5a0b5639/x11-base/xwayland/files/0001-Eliminate-conflict-with-X11-Xlib.h-with-khronos-eglp.patch?format=TEXT"
    uri_patch1 = URI.parse url_patch1
    filename_patch1 = 'patch1_base64'
    sha256sum_patch1 = '16f5d5d1986daf07b4e0f01eb0e68b53d8ef301d169f3cc9493158c8b4987f16'

    puts "Downloading patch1".yellow
    system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch1, '-o', filename_patch1)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
      Digest::SHA256.hexdigest( File.read( filename_patch1 ) ) == sha256sum_patch1
    puts "patch1 archive downloaded".lightgreen
    system 'base64 --decode patch1_base64 > patch1'
    system 'patch -p 1 < patch1'

    url_patch2 = "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/067ac4b5060c16e6687a97cbb4bcdbaf5a0b5639/x11-base/xwayland/files/0001-xwayland-Fall-back-to-gbm_bo_create-if-no-modifiers-.patch?format=TEXT"
    uri_patch2 = URI.parse url_patch2
    filename_patch2 = 'patch2_base64'
    sha256sum_patch2 = 'd44bfca0e26ca06892b37b12faca2a6756cdc2455aac36ac7607bfa188856b35'

    puts "Downloading patch2".yellow
    system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch2, '-o', filename_patch2)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
      Digest::SHA256.hexdigest( File.read( filename_patch2 ) ) == sha256sum_patch2
    puts "patch2 archive downloaded".lightgreen
    system 'base64 --decode patch2_base64 > patch2'
    system 'patch -p 1 < patch2'

    
    url_patch3 = "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/067ac4b5060c16e6687a97cbb4bcdbaf5a0b5639/x11-base/xwayland/files/0001-xwayland-sysmacros.patch?format=TEXT"
    uri_patch3 = URI.parse url_patch3
    filename_patch3 = 'patch3_base64'
    sha256sum_patch3 = 'b66eb66cc8023ab2170db91e4d6038dca99b814addfcb0977d30479a2e514ab8'

    puts "Downloading patch3".yellow
    system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch3, '-o', filename_patch3)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
      Digest::SHA256.hexdigest( File.read( filename_patch3 ) ) == sha256sum_patch3
    puts "patch3 archive downloaded".lightgreen
    system 'base64 --decode patch3_base64 > patch3'
    system 'patch -F 10 --force -p 1 < patch3'
  
  end

  case ARCH
   when 'armv7l', 'aarch64'
      PEER_CMD_PREFIX='/lib/ld-linux-armhf.so.3'
   when 'i686'
      PEER_CMD_PREFIX='/lib/ld-linux-i686.so.2'
   when 'x86_64'
      PEER_CMD_PREFIX='/lib64/ld-linux-x86-64.so.2'
  end

  def self.build
      ENV['CFLAGS'] = "-fuse-ld=lld"
      ENV['CXXFLAGS'] = "-fuse-ld=lld"
      system "meson setup build"
      system "meson configure #{CREW_MESON_OPTIONS} \
              -Dipv6=true \
              -Dxvfb=true \
              -Dxnest=true \
              -Dxcsecurity=true \
              -Dxorg=true \
              -Dxephyr=false \
              -Dxwayland=true \
              -Dglamor=true \
              -Dudev=true \
              -Ddocs=false \
              -Dxwin=false \
              -Dsystemd_logind=false \
              -Dlibunwind=true \
              -Dint10=false \
              -Dlog_dir=#{CREW_PREFIX}/var/log \
              build"
      system "meson configure build"
      system "ninja -C build"

      system "cat <<'EOF'> Xwayland_sh
#!/bin/bash
if base=$(readlink \"$0\" 2>/dev/null); then
  case $base in
  /*) base=$(readlink -f \"$0\" 2>/dev/null);; # if $0 is abspath symlink, make symlink fully resolved.
  *)  base=$(dirname \"$0\")/\"${base}\";;
  esac
else
  case $0 in
  /*) base=$0;;
  *)  base=${PWD:-`pwd`}/$0;;
  esac
fi
basedir=${base%/*}
# TODO(crbug/1003841): Remove LD_ARGV0 once
# ld.so supports forwarding the binary name.
LD_ARGV0=\"$0\" LD_ARGV0_REL=\"../bin/Xwayland.sh\" exec   \"${basedir}/..#{PEER_CMD_PREFIX}\"   --library-path \"${basedir}/../#{ARCH_LIB}\"   --inhibit-rpath ''   \"${base}.elf\"   \"$@\"
EOF"

  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/Xwayland.elf"
    system "install -Dm755 Xwayland_sh #{CREW_DEST_PREFIX}/bin/Xwayland"
    FileUtils.ln_sf "#{CREW_DEST_PREFIX}/bin/Xwayland", "#{CREW_DEST_PREFIX}/bin/X"
    end
end
