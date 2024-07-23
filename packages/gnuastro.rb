require 'buildsystems/autotools'

class Gnuastro < Autotools
  description 'GNU Astronomy Utilities'
  homepage 'https://www.gnu.org/software/gnuastro/'
  version '0.21'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnuastro/gnuastro-0.21.tar.gz'
  source_sha256 '2fba993d8422391517b55f7eb511788946d7a886aa1584984fd4678bdd27537f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a70f5925ea2986d81c3e890dcf541ee6e3da7e7b53a561c571abe62285587977',
     armv7l: 'a70f5925ea2986d81c3e890dcf541ee6e3da7e7b53a561c571abe62285587977',
       i686: '7159c651111a8b44a952120f4d12b91113175d74732fae93d1a0d1e97654107d',
     x86_64: 'e35a00f1090c838434c114d6eb56055a8b51c4bd57b175646437cdbde2a99d7b'
  })

  depends_on 'bzip2'
  depends_on 'cfitsio'
  depends_on 'curl'
  depends_on 'glibc'
  depends_on 'gsl'
  depends_on 'libgit2'
  depends_on 'libjpeg_turbo'
  depends_on 'libtiff'
  depends_on 'wcslib'
  depends_on 'xzutils'
  depends_on 'zlibpkg'
end
