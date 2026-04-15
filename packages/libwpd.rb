# Adapted from Arch Linux libwpd PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libwpd/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libwpd < Autotools
  description 'Library for importing WordPerfect tm documents'
  homepage 'https://libwpd.sourceforge.net/'
  version '0.10.3'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/sourceforge/libwpd/libwpd-#{version}.tar.xz"
  source_sha256 '2465b0b662fdc5d4e3bebcdc9a79027713fb629ca2bff04a3c9251fdec42dd09'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad5fca99f96d69903922da446465d3c97fa4a0fe58260d531a5e68e187849c94',
     armv7l: 'ad5fca99f96d69903922da446465d3c97fa4a0fe58260d531a5e68e187849c94',
     x86_64: 'b56b4ad2c61d08f369a778dbcb7714e18fd0641b293e2dbd76e5cec6479d3a48'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libgsf' => :build
  depends_on 'librevenge' => :library
  depends_on 'zlib' => :executable

  def self.patch
    patch = [
      [
        'https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/libwpd/trunk/libwpd-gcc11.patch',
        '7612c36e5e16df2b786fc4c905f096a6e7d600aade292e91950607bfbfba6c32'
      ]
    ]
    ConvenienceFunctions.patch(patch)
  end

  autotools_configure_options '--disable-static'

  run_tests
end
