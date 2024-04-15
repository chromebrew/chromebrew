# Adapted from Arch Linux libnsl PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnsl/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/autotools'

class Libnsl < Autotools
  description 'Public client interface library for NISYP'
  homepage 'https://github.com/thkukuk/libnsl'
  version '2.0.1'
  license 'LGPL-2.1-only'
  compatibility 'all'
  source_url 'https://github.com/thkukuk/libnsl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '98241094fd90933e8fbecb7ce04cde284253f3ba6e232c7703cabd2a38d7e4af',
    aarch64: '76c4fcec01143ca4534929d53b31df5b1b8d7dfa230d70f151275eca4b28bef3',
     armv7l: '76c4fcec01143ca4534929d53b31df5b1b8d7dfa230d70f151275eca4b28bef3',
     x86_64: 'b941648127b3756d4e8ad781060d3c9a884bdf2b080d8971864c19863ea07283'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libtirpc' # R

  configure_options '--disable-static'
end
