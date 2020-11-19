require 'package'

class Xwayland < Package
  description 'X server configured to work with weston or sommelier'
  homepage 'https://x.org'
  version '1.20.9-1'
  # Using xorg ToT due to large number of recent xwayland commits.
  source_url 'https://github.com/freedesktop/xorg-xserver/archive/28ed4b95e90fb225fc32cfdce16df603ab600fcd.zip'
  source_sha256 'e1311bdcaaf0fc61103804c5b4698679f4bac7a0dae97c2ac03dd32cb3cd0640'

  
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

    if File.exist?(filename_patch1) && Digest::SHA256.hexdigest( File.read("./#{filename_patch1}") ) == sha256sum_patch1
      puts "Unpacking patch1 source code".yellow
    else
      puts "Downloading patch1".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch1, '-o', filename_patch1)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_patch1}") ) == sha256sum_patch1
      puts "patch1 archive downloaded".lightgreen
      system 'base64 --decode patch1_base64 > patch1'
      system 'patch -p 1 < patch1'
    end
    

    url_patch2 = "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/067ac4b5060c16e6687a97cbb4bcdbaf5a0b5639/x11-base/xwayland/files/0001-xwayland-Fall-back-to-gbm_bo_create-if-no-modifiers-.patch?format=TEXT"
    uri_patch2 = URI.parse url_patch2
    filename_patch2 = 'patch2_base64'
    sha256sum_patch2 = 'd44bfca0e26ca06892b37b12faca2a6756cdc2455aac36ac7607bfa188856b35'

    if File.exist?(filename_patch2) && Digest::SHA256.hexdigest( File.read("./#{filename_patch2}") ) == sha256sum_patch2
      puts "Unpacking patch2 source code".yellow
    else
      puts "Downloading patch2".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch2, '-o', filename_patch2)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_patch2}") ) == sha256sum_patch2
      puts "patch2 archive downloaded".lightgreen
      system 'base64 --decode patch2_base64 > patch2'
      system 'patch -p 1 < patch2'
    end
    
    url_patch3 = "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/067ac4b5060c16e6687a97cbb4bcdbaf5a0b5639/x11-base/xwayland/files/0001-xwayland-sysmacros.patch?format=TEXT"
    uri_patch3 = URI.parse url_patch3
    filename_patch3 = 'patch3_base64'
    sha256sum_patch3 = 'b66eb66cc8023ab2170db91e4d6038dca99b814addfcb0977d30479a2e514ab8'

    if File.exist?(filename_patch3) && Digest::SHA256.hexdigest( File.read("./#{filename_patch3}") ) == sha256sum_patch3
      puts "Unpacking patch3 source code".yellow
    else
      puts "Downloading patch3".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch3, '-o', filename_patch3)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_patch3}") ) == sha256sum_patch3
      puts "patch3 archive downloaded".lightgreen
      system 'base64 --decode patch3_base64 > patch3'
      system 'patch -F 10 --force -p 1 < patch3'
    end

    url_patch4 = "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/067ac4b5060c16e6687a97cbb4bcdbaf5a0b5639/x11-base/xwayland/files/0001-xwayland-virtwl-with-dmabuf-for-1.20.1.patch?format=TEXT"
    uri_patch4 = URI.parse url_patch4
    filename_patch4 = 'patch4_base64'
    sha256sum_patch4 = '4d17671d40ccc4788bc977c82c5f2cda74a0c15d1d7c6a1c58ebe0357c4273cd'

    if File.exist?(filename_patch4) && Digest::SHA256.hexdigest( File.read("./#{filename_patch4}") ) == sha256sum_patch4
      puts "Unpacking patch4 source code".yellow
    else
      puts "Downloading patch4".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_patch4, '-o', filename_patch4)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_patch4}") ) == sha256sum_patch4
      puts "patch4 archive downloaded".lightgreen
      system 'base64 --decode patch4_base64 > patch4'
      system "sed -i \"s/xwayland.c\\b/xwayland-screen.c/\" patch4"
      system "sed -i \"s/xwayland.h\\b/xwayland-glamor.h/\" patch4"
      system "cat patch4"
      system 'patch --dry-run --force -F 100 -p 1 < patch4 || true'
      system "sed -i \"/Bool (\*allow_commits)(struct xwl_window \*xwl_window)/a struct wl_drm \*(*get_wl_drm_interface)(struct xwl_screen \*xwl_screen);\" hw/xwayland/xwayland-glamor.h"
    end
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
