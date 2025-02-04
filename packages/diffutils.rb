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
    aarch64: 'aa743845cc8c4fe2b452dfe3abe9e45e7c2f270b4cc7de72731f51ae269c0557',
     armv7l: 'aa743845cc8c4fe2b452dfe3abe9e45e7c2f270b4cc7de72731f51ae269c0557',
       i686: 'cf222ec2fdb2a77d3873e74059b030a7acd247401fd7521c9041d6609def8949',
     x86_64: '9b8a48ae9b82cbe8ca466749613d48b1e350023e3a773af30089ce1414f05e5d'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv'

  configure_options '--disable-year2038' unless ARCH == 'x86_64'
end
