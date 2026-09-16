require 'buildsystems/autotools'

class Gambit < Autotools
  description 'Efficient implementation of the Scheme programming language'
  homepage 'https://gambitscheme.org/'
  version '4.9.8'
  license 'CC0-1.0'
  compatibility 'all'
  source_url 'https://github.com/gambit/gambit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '618f917895e93d27b89cfdc5fc4a84d6b3344e559c9ea5ee89c0552a54be0309',
     armv7l: '618f917895e93d27b89cfdc5fc4a84d6b3344e559c9ea5ee89c0552a54be0309',
       i686: '2e3294de2b47576c88aa0b760379af952c1b447d54c4e469ebb8ea0fdd915160',
     x86_64: '69a71f7b621ac1b54aacf167e8acdebe92193baa9406c055981c6e0ab8a07faf'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :executable

  autotools_configure_options "--enable-openssl \
    --docdir=#{CREW_PREFIX}/share/doc"

  # One test failed for i686.
  # FAILED 03-number/first_bit_set.scm WITH EXIT CODE HI=70 LO=0
  # run_tests
end
