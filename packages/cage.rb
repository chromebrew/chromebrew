# Adapted from Arch Linux cage PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cage/trunk/PKGBUILD

require 'package'

class Cage < Package
  description 'A kiosk compositor for Wayland'
  homepage 'https://www.hjdskes.nl/projects/cage/'
  version '0.1.6-46f0ec1'
  license 'MIT'
  compatibility 'aarch64, armv7l, x86_64'
  source_url 'https://github.com/Hjdskes/cage.git'
  git_hashtag '46f0ec1b729cf2e4fb9c69bb8660e908d1311ea0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd95b7154eabc887c43cc93b68036f4f6cd71fd1eb81e51643cf5ca4c366b390',
     armv7l: 'dd95b7154eabc887c43cc93b68036f4f6cd71fd1eb81e51643cf5ca4c366b390',
     x86_64: '672f755177ce9f77c4d3d20fd3f7b0b99e6be657067cb61ed02841b2460d13ae'
  })

  depends_on 'glibc' # R
  depends_on 'libxkbcommon' # R
  depends_on 'pixman' => :build
  depends_on 'scdoc' => :build
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wlroots' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dxwayland=true \
      builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} meson install -C builddir"
  end
end
