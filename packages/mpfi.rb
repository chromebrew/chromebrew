# Adapted from Arch Linux mpfi PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mpfi/trunk/PKGBUILD

require 'buildsystems/autotools'

class Mpfi < Autotools
  description 'C library for interval arithmetic'
  homepage 'http://perso.ens-lyon.fr/nathalie.revol/software.html'
  version '1.5.4'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/arpra-project/mpfi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ecfafd1af8d377d2523c9168f7b04b17547b498a4ba6250c9bf9f618fda12de',
     armv7l: '8ecfafd1af8d377d2523c9168f7b04b17547b498a4ba6250c9bf9f618fda12de',
       i686: '0fc2834be57f62b6ec6ee6526b3c111831ec2764f6fdbcf99fda79cb3ec22570',
     x86_64: '073a932216160d49d18221eb11067fed5e41d7d69bc55007c1df3eae80cab9de'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'gnulib_git' => :build
  depends_on 'mpfr' => :library

  def self.patch
    patches = [
      ['https://salsa.debian.org/science-team/mpfi/-/raw/master/debian/patches/upstream-fix-tests-gcc14-technical_typo.patch?ref_type=heads&inline=false', 'fb6ba28419965b11088f71f25678bd0c83269413e2b7585ddccd4bf23c595d28'],
      ['https://salsa.debian.org/science-team/mpfi/-/raw/master/debian/patches/upstream-source-cleanup.patch?ref_type=heads&inline=false', 'c593847473294db704e942ddebcbc256a5b7e9caf4ac449f5db6a7a6901c5e31'],
      ['https://salsa.debian.org/science-team/mpfi/-/raw/master/debian/patches/upstream-tests-set_ld-not64bits-SKIP.patch?ref_type=heads&inline=false', 'f36fb51c45f91756b793102c00d24f3e030e9f9ecd8042c88c83ada28b86af14'],
      ['https://salsa.debian.org/science-team/mpfi/-/raw/master/debian/patches/upstream-autotools-refresh.patch?ref_type=heads&inline=false', '7710936284bce2ed669690d75f811bbdd85936175490aa6105902324ce46de0c'],
      ['https://salsa.debian.org/science-team/mpfi/-/raw/master/debian/patches/upstream-libtoolization-version_script.patch?ref_type=heads&inline=false', 'fe16c1d76e9465368ebd39650993a6aebac1c3f4e2f20ada5ee1c9d7d58d31f2']
    ]
    ConvenienceFunctions.patch(patches)
  end

  autotools_configure_options '--enable-maintainer-mode'
end
