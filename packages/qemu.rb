require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  @_ver = '6.2.0'
  version @_ver
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/qemu/qemu.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/6.2.0_armv7l/qemu-6.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/6.2.0_armv7l/qemu-6.2.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qemu/6.2.0_x86_64/qemu-6.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c3446bacc562d8ca3320d20d48922270dfc7300c64d29031a440c19a032c5880',
     armv7l: 'c3446bacc562d8ca3320d20d48922270dfc7300c64d29031a440c19a032c5880',
     x86_64: 'b51aab47f59c927803b2c25313a326f7539d2d0a984094389abea78d8366b624'
  })

  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'jemalloc'
  depends_on 'libaio'
  depends_on 'libcap_ng'
  depends_on 'libgcrypt'
  depends_on 'libsdl2'
  depends_on 'libusb'
  depends_on 'lzo'
  depends_on 'pixman'
  depends_on 'hicolor_icon_theme'

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir 'build' do
      system "#{CREW_ENV_OPTIONS} ../configure #{CREW_OPTIONS.sub(/--target.*/, '')} \
        --disable-stack-protector \
        --enable-lto"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
