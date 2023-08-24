require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '8.1.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/qemu/qemu.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/8.1.0_armv7l/qemu-8.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/8.1.0_armv7l/qemu-8.1.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/8.1.0_x86_64/qemu-8.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '35e5a86f8c3dea83508f69f423a51a1291cd9cece4f6e13c02fa7c865917d139',
     armv7l: '35e5a86f8c3dea83508f69f423a51a1291cd9cece4f6e13c02fa7c865917d139',
     x86_64: '0443fab996ef671cbea33224ec80b14f7b5c6e3418219fcda27adc8074461acb'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'eudev' # R
  depends_on 'elfutils' # R
  depends_on 'fontconfig' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'jack' # R
  depends_on 'jemalloc'
  depends_on 'libaio' # R
  depends_on 'libcap_ng' # R
  depends_on 'libepoxy' # R
  depends_on 'libgcrypt'
  depends_on 'libjpeg' # R
  depends_on 'libsdl2' # R
  depends_on 'libusb' # R
  depends_on 'libx11' # R
  depends_on 'libxkbcommon' # R
  depends_on 'linux_pam' # R
  depends_on 'lzo' # R
  depends_on 'mesa' # R
  depends_on 'pango' # R
  depends_on 'pipewire' # R
  depends_on 'pixman' # R
  depends_on 'pulseaudio' # R
  depends_on 'sdl2_image' # R
  depends_on 'snappy' # R
  depends_on 'bz2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'curl' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libpng' # R
  depends_on 'libseccomp' # R
  depends_on 'libssh' # R
  depends_on 'ncurses' # R
  depends_on 'vte' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R
  depends_on 'glibc_lib' # R

  def self.preflight
    abort "Qemu requires glibc 2.35. The current glibc version is #{LIBC_VERSION}.".lightred unless Gem::Version.new(LIBC_VERSION.to_s) == Gem::Version.new('2.35')
  end

  def self.patch
    # Avoid linux/usbdevice_fs.h:88:9: error: unknown type name ‘u8’ error
    FileUtils.mkdir_p 'linux'
    FileUtils.cp "#{CREW_PREFIX}/include/linux/usbdevice_fs.h", 'linux/usbdevice_fs.h'
    system "sed -i 's,^\\([[:blank:]]*\\)u8,\\1__u8,g' linux/usbdevice_fs.h"
    system "sed -i 's,<linux/usbdevice_fs.h>,\"linux/usbdevice_fs.h\",g' hw/usb/host-libusb.c"
  end

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir 'build' do
      system "mold -run ../configure #{CREW_OPTIONS.sub(/--target.*/, '')} \
        --enable-lto"
      @counter = 1
      @counter_max = 20
      loop do
        break if Kernel.system "make -j #{CREW_NPROC}"

        puts "Make iteration #{@counter} of #{@counter_max}...".orange

        @counter += 1
        break if @counter > @counter_max
      end
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
