require 'buildsystems/autotools'

class Motif < Autotools
  description 'Motif is a freely available source code distribution for the Motif user interface component toolkit.'
  homepage 'https://motif.ics.com/'
  version '2.5.2'
  license 'LGPL-2.1+ and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/thentenaar/motif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a09405b3c5573fa557388cb0fc6a562100afe447bb451d34f752a2df6a86285',
     armv7l: '4a09405b3c5573fa557388cb0fc6a562100afe447bb451d34f752a2df6a86285',
     x86_64: '1b294be4e0909d9e49a37fa0d430a7b3bdc9cc7ac5e4f311294fd589d9cf59ac'
  })

  depends_on 'check' => :build
  depends_on 'expat' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libbsd' => :executable
  depends_on 'libice' => :executable
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libmd' => :library
  depends_on 'libpng' => :library
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :library
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxcursor' => :library
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :executable
  depends_on 'libxft' => :library
  depends_on 'libxmu' => :library
  depends_on 'libxpm' => :library
  depends_on 'libxrandr' => :library
  depends_on 'libxrender' => :library
  depends_on 'libxt' => :library
  depends_on 'sommelier' => :logical
  depends_on 'util_linux' => :executable
  depends_on 'xbitmaps' => :library
  depends_on 'zlib' => :library

  autotools_configure_options ' \
      --with-x \
      --enable-xft \
      --enable-png \
      --enable-jpeg'

  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
    ConvenienceFunctions.libtoolize('libXfixes', 'libxfixes')
    ConvenienceFunctions.libtoolize('libXrender', 'libxrender')
  end

  # Tests fail with many mold errors.
  # mold: error: undefined symbol: srunner_run_all
  # mold: error: undefined symbol: tcase_create
  # mold: error: undefined symbol: srunner_create
  # mold: error: undefined symbol: _mark_point
  # mold: error: undefined symbol: srunner_set_fork_status
  # mold: error: undefined symbol: _tcase_add_test
  # mold: error: undefined symbol: suite_create
  # mold: error: undefined symbol: srunner_set_xml
  # mold: error: undefined symbol: srunner_free
  # mold: error: undefined symbol: _ck_assert_failed
  # mold: error: undefined symbol: tcase_set_timeout
  # mold: error: undefined symbol: tcase_add_checked_fixture
  # mold: error: undefined symbol: srunner_add_suite
  # mold: error: undefined symbol: srunner_ntests_failed
  # mold: error: undefined symbol: suite_add_tcase
  # run_tests
end
