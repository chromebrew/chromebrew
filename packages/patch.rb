require 'buildsystems/autotools'

class Patch < Autotools
  description 'Patch takes a patch file containing a difference listing produced by the diff program and applies those differences to one or more original files, producing patched versions.'
  homepage 'https://www.gnu.org/software/patch/'
  version '2.8'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/patch/patch-#{version}.tar.xz"
  source_sha256 'ac610bda97abe0d9f6b7c963255a11dcb196c25e337c61f94e4778d632f1d8fd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5ed23759094417cda17c86653388d8bfdacd8073f50b63754115bd1e3470718',
     armv7l: 'f5ed23759094417cda17c86653388d8bfdacd8073f50b63754115bd1e3470718',
       i686: '4e7dac3d38983a690496b00163b6a331754f9d510781a922f02fb2cedf1fe7ed',
     x86_64: '2c756988d1ed11102e6bc33146d43349e303bac645ec8d16ef7ec521f3d0b5d9'
  })

  depends_on 'attr' # R
  depends_on 'glibc' # R

  year2038 = ARCH.include?('x86_64') ? '' : '--disable-year2038'
  configure_options year2038

  run_tests
end
