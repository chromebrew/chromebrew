require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'https://www.qemu.org/'
  version '6.1.0'
  license 'GPL-2, LGPL-2 and BSD-2'
  compatibility 'all'
  source_url 'https://gitlab.com/qemu-project/qemu.git'
  git_hashtag "v#{version}"

  depends_on 'bz2'
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

  @_virgl = '--enable-virglrenderer --enable-opengl' if File.exist?("#{CREW_META_PATH}/virglrenderer.filelist")
 
  def self.build
    system <<~BUILD
      env #{CREW_ENV_OPTIONS} \
      ./configure \
        #{CREW_OPTIONS.sub(/--target=.+/, '')} #{@_virgl} \
        --enable-gtk \
        --enable-sdl \
        --enable-kvm \
        --enable-system \
        --enable-modules
    BUILD

    system 'samu -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C build install"
  end
end
