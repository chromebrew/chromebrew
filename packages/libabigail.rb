# Adapted from Arch Linux libabigail PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libabigail

require 'buildsystems/autotools'

class Libabigail < Autotools
  description 'ABI Generic Analysis and Instrumentation Library'
  homepage 'https://sourceware.org/libabigail/'
  version '2.5-py3.12'
  license 'Apache'
  compatibility 'all'
  source_url 'https://sourceware.org/git/libabigail.git'
  git_hashtag "libabigail-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '450734b97afc1dfca6ef49224af28470cbe60f71c3cb49ef618645ad8a408cec',
     armv7l: '450734b97afc1dfca6ef49224af28470cbe60f71c3cb49ef618645ad8a408cec',
       i686: '8abe86ed59dee6eb9b597153d064333db38bab3392e9ac4c308a6f1f3b3905c8',
     x86_64: '6af286b67a55f5765e724ee1bd3ca43c153cd07b91e016f18a9cf5c96435ecc2'
  })

  depends_on 'binutils' # R
  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'python3' => :build
  depends_on 'sphinx' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  configure_options '--enable-bash-completion \
    --disable-manual \
    --disable-apidoc \
    --disable-static'
end
