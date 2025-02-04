require 'buildsystems/autotools'

class Diffutils < Autotools
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.11'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/diffutils/diffutils-#{version}.tar.xz"
  source_sha256 'a73ef05fe37dd585f7d87068e4a0639760419f810138bd75c61ddaa1f9e2131e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbef572e4982395a2b603cd5498e50402123887e9a3327640c71b133d917df11',
     armv7l: 'bbef572e4982395a2b603cd5498e50402123887e9a3327640c71b133d917df11',
       i686: '5be08736ce8d850ee3ded9b3be61f543c52f6ce00a0738f1432163e1c5066701',
     x86_64: 'c9dfed42391fa1a458d10af617d05fa16f79c066ee4d723e00bc73a98aa92f1d'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv'

  configure_options '--disable-year2038' unless ARCH == 'x86_64'
end
