require 'buildsystems/autotools'

class Diffutils < Autotools
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.12'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/diffutils/diffutils-#{version}.tar.xz"
  source_sha256 '7c8b7f9fc8609141fdea9cece85249d308624391ff61dedaf528fcb337727dfd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbef572e4982395a2b603cd5498e50402123887e9a3327640c71b133d917df11',
     armv7l: 'bbef572e4982395a2b603cd5498e50402123887e9a3327640c71b133d917df11',
       i686: '8e11ee13f8672b8c8173fa633f179b87eec4aeece387a841be6c369d24729206',
     x86_64: 'c9dfed42391fa1a458d10af617d05fa16f79c066ee4d723e00bc73a98aa92f1d'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv' # R

  configure_options '--disable-year2038' unless ARCH == 'x86_64'
end
