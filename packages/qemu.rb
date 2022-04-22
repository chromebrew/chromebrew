require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  @_ver = '7.0.0'
  version @_ver
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/qemu/qemu.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/7.0.0_armv7l/qemu-7.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/7.0.0_armv7l/qemu-7.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/7.0.0_x86_64/qemu-7.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5c628a3b1106b46ce76bc46bfe31b929210dc4ace9b343582d331b7191cf9281',
     armv7l: '5c628a3b1106b46ce76bc46bfe31b929210dc4ace9b343582d331b7191cf9281',
     x86_64: 'a0130ee4038e2c28eff096a362dcb4d33413c7d06be4fb613d56e3f6a5500089'
  })

  depends_on 'alsa_lib' # R
  depends_on 'atk' # R
  depends_on 'cairo' # R
  depends_on 'eudev' # R
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
  patchelf

  def self.patch
    # Avoid linux/usbdevice_fs.h:88:9: error: unknown type name ‘u8’ error
    FileUtils.mkdir_p 'linux'
    FileUtils.cp "#{CREW_PREFIX}/include/linux/usbdevice_fs.h", 'linux/usbdevice_fs.h'
    system "sed -i 's,^\\\([[:blank:]]*\\\)u8,\\1__u8,g' linux/usbdevice_fs.h"
    system "sed -i 's,<linux/usbdevice_fs.h>,\"linux/usbdevice_fs.h\",g' hw/usb/host-libusb.c"
  end

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir 'build' do
      system "../configure #{CREW_OPTIONS.sub(/--target.*/, '')} \
        --disable-stack-protector \
        --enable-lto"
      system 'make || make -j1'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
