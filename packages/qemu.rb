require 'buildsystems/autotools'

class Qemu < Autotools
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'https://www.qemu.org/'
  version '11.0.2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/qemu/qemu.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '2df6984d580a95836093ca25ccd234ed7c1f6f9291a2eee56bd9657dda712280'
  })

  depends_on 'alsa_lib' => :executable
  depends_on 'at_spi2_core' => :build
  depends_on 'bzip2' => :executable
  depends_on 'cairo' => :executable
  depends_on 'curl' => :executable
  depends_on 'elfutils' => :executable
  depends_on 'eudev' => :executable
  depends_on 'fftw' => :build
  depends_on 'fontconfig' => :build
  depends_on 'fuse3' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :build
  depends_on 'hicolor_icon_theme' => :build
  depends_on 'jack' => :executable
  depends_on 'jemalloc' => :build
  depends_on 'libaio' => :executable
  depends_on 'libcap_ng' => :executable
  depends_on 'libcyrussasl' => :executable
  depends_on 'libepoxy' => :executable
  depends_on 'libgcrypt' => :build
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libnfs' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libsamplerate' => :build
  depends_on 'libseccomp' => :executable
  depends_on 'libslirp' => :executable
  depends_on 'libssh' => :executable
  depends_on 'libusb' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'linux_pam' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'lzfse' => :executable
  depends_on 'lzo' => :executable
  depends_on 'mesa' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pango' => :build
  depends_on 'pipewire' => :executable
  depends_on 'pixman' => :executable
  depends_on 'pulseaudio' => :executable
  depends_on 'py3_sphinx_rtd_theme' => :build
  depends_on 'py3_sphinxcontrib_jquery' => :build
  depends_on 'rust_bindgen' => :build
  depends_on 'sdl2' => :executable
  depends_on 'sdl2_compat' => :executable
  depends_on 'sdl2_image' => :executable
  depends_on 'sdl3' => :build
  depends_on 'sdl3_image' => :build
  depends_on 'snappy' => :executable
  depends_on 'sphinx' => :build
  depends_on 'vte' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  def self.patch
    # Deal with bswap.h error: array subscript 'unsigned long[0]' is partly outside array bounds of 'void[4]'
    bswap_gcc16_ignore = <<~BSWAP_EOF
      #if __GNUC__==16
          // see https://gitlab.com/libeigen/eigen/-/issues/2506
          // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106247
          #pragma GCC diagnostic ignored "-Warray-bounds"
      #endif
    BSWAP_EOF
    File.write 'include/qemu/bswap.h', bswap_gcc16_ignore + File.read('include/qemu/bswap.h')
    # See https://patchew.org/QEMU/20230808150636.91154-1-akihiko.odaki@daynix.com/
    File.write 'MAP_FIXED_NOREPLACE.patch', <<~MAP_FIXED_NOREPLACE_EOF
      diff -Npaur a/include/qemu/osdep.h b/include/qemu/osdep.h
      --- a/include/qemu/osdep.h	2026-05-24 22:28:56.876962523 -0400
      +++ b/include/qemu/osdep.h	2026-05-24 22:34:07.110162397 -0400
      @@ -328,6 +328,13 @@ void QEMU_ERROR("code path is reachable"
       #ifndef MAP_ANONYMOUS
       #define MAP_ANONYMOUS MAP_ANON
       #endif
      +#if defined(__linux__) && !defined(MAP_FIXED_NOREPLACE)
      +#if MAP_HUGETLB == 0x100000
      +#define MAP_FIXED_NOREPLACE 0x200000
      +#else
      +#define MAP_FIXED_NOREPLACE 0x100000
      +#endif
      +#endif
       #ifndef MAP_NORESERVE
       #define MAP_NORESERVE 0
       #endif
    MAP_FIXED_NOREPLACE_EOF
    system 'patch -Np1 -i MAP_FIXED_NOREPLACE.patch'
    # https://patchew.org/QEMU/20230810215706.1394220-1-iii@linux.ibm.com/20230810215706.1394220-3-iii@linux.ibm.com/
    File.write 'MAP_SHARED_VALIDATE.patch', <<~MAP_SHARED_VALIDATE_EOF
      diff --git a/linux-user/syscall.c b/linux-user/syscall.c
      index 42f4aed8e84..256f38cdd5d 100644
      --- a/linux-user/syscall.c
      +++ b/linux-user/syscall.c
      @@ -121,6 +121,7 @@
       #ifdef HAVE_BTRFS_H
       #include <linux/btrfs.h>
       #endif
      +#include <linux/mman.h>
       #ifdef HAVE_DRM_H
       #include <libdrm/drm.h>
       #include <libdrm/i915_drm.h>
    MAP_SHARED_VALIDATE_EOF
    system 'patch -Np1 -i MAP_SHARED_VALIDATE.patch'
    # Handle with -Wno-maybe-uninitialized instead of disabling i3c:
    # FAILED: [code=1] libsystem.a.p/hw_i3c_core.c.o
    # cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt -Isubprojects/libvduse -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader -I/usr/local/include/p11-ki
    # t-1 -I/usr/local/include/pixman-1 -I/usr/local/include/libpng16 -I/usr/local/include/libusb-1.0 -I/usr/local/include/SDL2 -I/usr/local/include/glib-2.0 -I/usr/local/lib64/glib-2.0/include -I/usr
    # /local/include/libmount -I/usr/local/include/blkid -I/usr/local/include/gio-unix-2.0 -I/usr/local/include/slirp -I/usr/local/include/ncursesw -I/usr/local/include/gtk-3.0 -I/usr/local/include/pa
    # ngo-1.0 -I/usr/local/include/cairo -I/usr/local/include/gdk-pixbuf-2.0 -I/usr/local/include/at-spi2-atk/2.0 -I/usr/local/include/at-spi-2.0 -I/usr/local/include/atk-1.0 -I/usr/local/include/dbus
    # -1.0 -I/usr/local/lib64/dbus-1.0/include -I/usr/local/include/fribidi -I/usr/local/include/harfbuzz -I/usr/local/include/freetype2 -I/usr/local/include/vte-2.91 -I/usr/local/include/fuse3 -I/usr
    # /local/include/pipewire-0.3 -I/usr/local/include/spa-0.2 -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -mcx16 -msse2 -fno-link-libatomic -D_GNU_SOURCE -D_FILE_OFFSET_BIT
    # S=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-
    # defined -Wformat-overflow=2 -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-
    # declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
    # -isystem /usr/local/tmp/crew/qemu.20260524222806.dir/linux-headers -isystem linux-headers -iquote . -iquote /usr/local/tmp/crew/qemu.20260524222806.dir -iquote /usr/local/tmp/crew/qemu.20260524
    # 222806.dir/include -iquote /usr/local/tmp/crew/qemu.20260524222806.dir/host/include/x86_64 -iquote /usr/local/tmp/crew/qemu.20260524222806.dir/host/include/generic -iquote /usr/local/tmp/crew/qe
    # mu.20260524222806.dir/tcg/x86_64 -pthread -O3 -pipe -ffat-lto-objects -fPIC -fuse-ld=mold -flto=auto -flto=auto -fPIE -fno-strict-aliasing -fno-strict-overflow -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=
    # 600 -DNCURSES_WIDECHAR=1 -D_REENTRANT -DSTRUCT_IOVEC_DEFINED -DCONFIG_SOFTMMU -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_i3c_core.c.o -MF libsystem.a.p/hw_i3c_core.c.o.d -o libsystem.a.
    # p/hw_i3c_core.c.o -c ../hw/i3c/core.c
    # In file included from ../hw/i3c/trace.h:2,
    # from ../hw/i3c/core.c:12:
    # In function ‘trace_i3c_recv’,
    # inlined from ‘i3c_recv’ at ../hw/i3c/core.c:480:5,
    # inlined from ‘i3c_recv_byte’ at ../hw/i3c/core.c:450:12:
    # ../hw/i3c/trace-events:33:13: error: ‘num_read’ may be used uninitialized [-Werror=maybe-uninitialized]
    # 33 | i3c_recv(uint32_t num_read, uint32_t num_to_read, bool ack) "I3C recv %" PRId32 "/%" PRId32 " bytes, ack=%d"
    # |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # ../hw/i3c/core.c: In function ‘i3c_recv_byte’:
    # ../hw/i3c/core.c:449:14: note: ‘num_read’ was declared here
    # 449 |     uint32_t num_read;
    # |              ^~~~~~~~
    # cc1: all warnings being treated as errors

    # Handle with -Wno-stringop-overflow:
    # [2951/6742] Compiling C object libsystem.a.p/hw_ssi_xilinx_spips.c.o
    # FAILED: [code=1] libsystem.a.p/hw_ssi_xilinx_spips.c.o
    # cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt -Isubprojects/libvduse -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader -I/usr/local/include/p11-ki
    # t-1 -I/usr/local/include/pixman-1 -I/usr/local/include/libpng16 -I/usr/local/include/libusb-1.0 -I/usr/local/include/SDL2 -I/usr/local/include/glib-2.0 -I/usr/local/lib64/glib-2.0/include -I/usr
    # /local/include/libmount -I/usr/local/include/blkid -I/usr/local/include/gio-unix-2.0 -I/usr/local/include/slirp -I/usr/local/include/ncursesw -I/usr/local/include/gtk-3.0 -I/usr/local/include/pa
    # ngo-1.0 -I/usr/local/include/cairo -I/usr/local/include/gdk-pixbuf-2.0 -I/usr/local/include/at-spi2-atk/2.0 -I/usr/local/include/at-spi-2.0 -I/usr/local/include/atk-1.0 -I/usr/local/include/dbus
    # -1.0 -I/usr/local/lib64/dbus-1.0/include -I/usr/local/include/fribidi -I/usr/local/include/harfbuzz -I/usr/local/include/freetype2 -I/usr/local/include/vte-2.91 -I/usr/local/include/fuse3 -I/usr
    # /local/include/pipewire-0.3 -I/usr/local/include/spa-0.2 -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -mcx16 -msse2 -fno-link-libatomic -D_GNU_SOURCE -D_FILE_OFFSET_BIT
    # S=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-
    # defined -Wformat-overflow=2 -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-
    # declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
    # -isystem /usr/local/tmp/crew/qemu.20260525005015.dir/linux-headers -isystem linux-headers -iquote . -iquote /usr/local/tmp/crew/qemu.20260525005015.dir -iquote /usr/local/tmp/crew/qemu.20260525
    # 005015.dir/include -iquote /usr/local/tmp/crew/qemu.20260525005015.dir/host/include/x86_64 -iquote /usr/local/tmp/crew/qemu.20260525005015.dir/host/include/generic -iquote /usr/local/tmp/crew/qe
    # mu.20260525005015.dir/tcg/x86_64 -pthread -O3 -pipe -ffat-lto-objects -fPIC -fuse-ld=mold -flto=auto -flto=auto -fPIE -fno-strict-aliasing -fno-strict-overflow -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=
    # 600 -DNCURSES_WIDECHAR=1 -D_REENTRANT -DSTRUCT_IOVEC_DEFINED -DCONFIG_SOFTMMU -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_ssi_xilinx_spips.c.o -MF libsystem.a.p/hw_ssi_xilinx_spips.c.o.d
    # -o libsystem.a.p/hw_ssi_xilinx_spips.c.o -c ../hw/ssi/xilinx_spips.c
    # ../hw/ssi/xilinx_spips.c: In function ‘xilinx_spips_flush_txfifo’:
    # ../hw/ssi/xilinx_spips.c:624:30: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
    # 624 |                     tx_rx[i] = fifo8_pop(&s->tx_fifo);
    # |                     ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
    # ../hw/ssi/xilinx_spips.c:613:17: note: at offset 2 into destination object ‘tx_rx’ of size 2
    # 613 |         uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
    # |                 ^~~~~
    # cc1: all warnings being treated as errors
  end

  autotools_configure_modifications [/--program-prefix=.*/, '']
  autotools_configure_options "--enable-rust --ninja=ninja --extra-cflags='-Wno-stringop-overflow -Wno-maybe-uninitialized'"
end
