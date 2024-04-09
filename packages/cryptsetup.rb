require 'buildsystems/autotools'

class Cryptsetup < Autotools
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.7.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/utils/cryptsetup/v2.7/cryptsetup-2.7.2.tar.xz'
  source_sha256 '219ebf74e8eddf96624a0376477e5a6f8f350a67aaf36e7dadb114d94b3afef4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af2704c4aa03ab19b341dea6df7153ab39520faa9aca32d0f87bf03edd63f98b',
     armv7l: 'af2704c4aa03ab19b341dea6df7153ab39520faa9aca32d0f87bf03edd63f98b',
       i686: 'b617e0e29799b80335a169f38ec8100d7e2d38506f031e510e0ab776dd16482c',
     x86_64: 'cc366cd896898841a29ec7d326e0c00616fb6b09761397b18422d9e323b3c9aa'
  })

  depends_on 'util_linux'
  depends_on 'lvm2'
  depends_on 'jsonc'
  depends_on 'libgcrypt'
  depends_on 'popt'

  configure_options '--disable-asciidoc'
end
