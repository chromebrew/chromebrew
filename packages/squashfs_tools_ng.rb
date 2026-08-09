# Adapted from Arch Linux squashfs-tools-ng PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=squashfs-tools-ng

require 'buildsystems/autotools'

class Squashfs_tools_ng < Autotools
  description 'A new set of tools and libraries for working with SquashFS images'
  homepage 'https://infraroot.at/projects/squashfs-tools-ng/index.html'
  version '1.3.2'
  license 'GPLv3'
  compatibility 'all'
  source_url "https://infraroot.at/pub/squashfs/squashfs-tools-ng-#{version}.tar.xz"
  source_sha256 '0d907ac3e735c351e47c867fb51d94bffa3b05fb95bec01f31e848b7c44215a9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3d5831a23e4d35cd41e335bb60dac7af83ac025e60933944234aaca12b35843',
     armv7l: 'c3d5831a23e4d35cd41e335bb60dac7af83ac025e60933944234aaca12b35843',
       i686: '64b8ebf3f07647106bcc97b730fdccf0e6c900c1f2937c87f69eb0e84f7b6a9c',
     x86_64: '1fc538c1984aa003dbcd05b1613c09fe2f05cd91fb0b059e729c4960394fda48'
  })

  depends_on 'bzip2' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lz4' => :library
  depends_on 'lzo' => :executable
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_build_extras do
    system 'make doxygen-doc'
  end
end
