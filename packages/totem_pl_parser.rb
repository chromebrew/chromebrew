require 'buildsystems/meson'

class Totem_pl_parser < Meson
  description 'Totem playlist parsing library'
  homepage 'https://gitlab.gnome.org/GNOME/totem-pl-parser'
  version '3.26.7'
  license 'LGPL GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.gnome.org/sources/totem-pl-parser/#{version.split('.')[0..1].join('.')}/totem-pl-parser-#{version}.tar.xz"
  source_sha256 '60d517c1acabe54ae337f64451264fc76730696eaae26b5480fb37166689b5f3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '985a8f2eda4f5bb4f75c6c1757deb88bf0c40d67088157bd3f0c738da0b2cb3a',
     armv7l: '985a8f2eda4f5bb4f75c6c1757deb88bf0c40d67088157bd3f0c738da0b2cb3a',
     x86_64: '21d088f2c3d3bc5fa1f960f1ea0b9f5d4b725d4e781707f5316bdb6a0c10c4c7'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'libarchive' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libsoup' => :library
  depends_on 'libxml2' => :library
  depends_on 'uchardet' => :library

  gnome
end
