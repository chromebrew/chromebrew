# Adapted from Arch Linux spice-protocol PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/spice-protocol/trunk/PKGBUILD

require 'package'

class Spice_protocol < Package
  description 'Headers for SPICE protocol'
  homepage 'https://spice-space.org'
  version '0.14.3'
  license 'BSD LGPL2.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/spice/spice-protocol/-/archive/v0.14.3/spice-protocol-v0.14.3.tar.gz'
  source_sha256 '80ae89643e253dc5ddc5b2120cd3cf9d9565d00026ff261dd140d4b8c5deaa64'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '7ac004bbebd8ba03ca9ed896d222faed432055b8f168b7274d93dd5036c8f8f3',
     armv7l: '7ac004bbebd8ba03ca9ed896d222faed432055b8f168b7274d93dd5036c8f8f3',
       i686: '4bba8bef9ea383f9a8175e392dcaa2d650f3e04dcbfe3b82d600b277601c76c4',
     x86_64: '512a3071dd74307c7a78b512d75747869373da34e6fabacbc59ff1d33cb66990'
  })

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
