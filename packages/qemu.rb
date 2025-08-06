require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'https://www.qemu.org/'
  version '10.0.3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29' # Needed for MAP_FIXED_NOREPLACE support.
  source_url 'https://github.com/qemu/qemu.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b07e876cca85b8003be705aee939d5676e0a8109fa69bfb3d7a3cb16d986e67d',
     armv7l: 'b07e876cca85b8003be705aee939d5676e0a8109fa69bfb3d7a3cb16d986e67d',
     x86_64: '30183ad202272d2d568a6da30a58ad228cd1b42daebee015051703cbdd88eafe'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'jemalloc'
  depends_on 'libaio' # R
  depends_on 'libcap_ng' # R
  depends_on 'libgcrypt'
  depends_on 'libssh' # R
  depends_on 'libxkbcommon' # R
  depends_on 'linux_pam' # R
  depends_on 'lzfse' # R
  depends_on 'py3_sphinx_rtd_theme' => :build
  depends_on 'rust' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
      system '../configure --help'
      system "../configure #{CREW_CONFIGURE_OPTIONS.sub(/--target.*/, '').gsub('vfpv3-d16', 'neon').gsub('--disable-dependency-tracking', '').sub(/--program-prefix.*?(?=\s|$)/, '').sub(/--program-suffix.*?(?=\s|$)/, '')} \
        --enable-kvm \
        --disable-tcg"
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
