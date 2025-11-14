# Adapted from Arch Linux libmspack PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libmspack/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libmspack < Autotools
  description 'A library for Microsoft compression formats'
  homepage 'https://www.cabextract.org.uk/libmspack/'
  version '0.11alpha'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/kyz/libmspack.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46d6df38b214646cf563ded45a1806c1e4c2a6ad0fc40dea7f6d8f7f6e62872c',
     armv7l: '46d6df38b214646cf563ded45a1806c1e4c2a6ad0fc40dea7f6d8f7f6e62872c',
       i686: '319c935908e66848c4cc078cfdfdd0b90f6002f48c04bf20936df11bb64063f9',
     x86_64: '39275f1307ce586145821a51e3dd53f16528b219f126d716278a41f7cd8ef0f6'
  })

  depends_on 'glibc' # R

  autotools_build_relative_dir 'libmspack'
  autotools_configure_options '--disable-static'
end
