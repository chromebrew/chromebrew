# Adapted from Arch Linux sord PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sord/trunk/PKGBUILD

require 'buildsystems/meson'

class Sord < Meson
  description 'A lightweight C library for storing RDF data in memory'
  homepage 'https://drobilla.net/software/sord/'
  version '0.16.22'
  license 'ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/sord.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4535cb14e24b286579e8db853f23f92f78f7fb0886cd66479364dc092f4e9e8',
     armv7l: 'c4535cb14e24b286579e8db853f23f92f78f7fb0886cd66479364dc092f4e9e8',
       i686: '71f246ce23adb3a1914d09f14c76ddc03d1eaa1623bc07cee7e9867d65f2ef6e',
     x86_64: '5bd20c773127a64b4ade1f1803440fae3ab9b963c6b597926d3b0bd1389387c1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'pcre2' => :executable
  depends_on 'serd' => :library
  depends_on 'zix' => :library

  meson_options '-Ddocs=disabled -Dtests=disabled'
end
