require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '6.0.0'
  license 'GPL-2, LGPL-2 and BSD-2'
  compatibility 'all'
  source_url 'https://download.qemu.org/qemu-6.0.0.tar.xz'
  source_sha256 '87bc1a471ca24b97e7005711066007d443423d19aacda3d442558ae032fa30b9'

  binary_url ({

  })
  binary_sha256 ({

  })

  depends_on 'bz2'
  depends_on 'libcurl'
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


  @_virgl = <<~OPT if File.exist?("#{CREW_META_PATH}/virglrenderer.filelist")
    --enable-virglrenderer \
    --enable-opengl
  OPT
 
  def self.build
    system <<~BUILD
      env #{CREW_ENV_OPTIONS} \
      ./configure \
        #{CREW_OPTIONS} \
        #{@_virgl} \
        --enable-kvm \
        --enable-system \
        --enable-modules
    BUILD
    # --enable-gtk
    # --enable-sdl
    # --disable-stack-protector

    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
