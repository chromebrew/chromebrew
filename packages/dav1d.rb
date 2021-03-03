require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  @_ver = '0.8.2'
  version @_ver
  compatibility 'all'
  source_url "https://get.videolan.org/dav1d/#{@_ver}/dav1d-#{@_ver}.tar.xz"
  source_sha256 '3dd91d96b44e9d8ba7e82ad9e730d6c579ab5e19edca0db857a60f5ae6a0eb13'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.8.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.8.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.8.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.8.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1e55f2fb0514c8a5fb6b991a2280495b0706ff95f5ae4013e67e70de2e8b5bfe',
      armv7l: '1e55f2fb0514c8a5fb6b991a2280495b0706ff95f5ae4013e67e70de2e8b5bfe',
        i686: 'a2115b3d09915b60f6fdffff5ad624df55bbfb3207b55eea08277b77680c34c9',
      x86_64: '86edb8b9bcd8d7ae8e5062da704f8c223a7c3745340108d13325100c96aafb2e',
  })

  depends_on 'nasm' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
