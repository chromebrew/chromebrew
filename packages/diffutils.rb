require 'buildsystems/autotools'

class Diffutils < Autotools
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.12-2591992'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/diffutils.git'
  git_hashtag '25919920377f08d6f09df804c7f8af11f5adaabe'
  # git_hashtag "v#{version.split('-').first}"
  # source_url "https://ftpmirror.gnu.org/diffutils/diffutils-#{version.split('-').first}.tar.xz"
  # source_sha256 '7c8b7f9fc8609141fdea9cece85249d308624391ff61dedaf528fcb337727dfd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf0ff62b56328ae1c00e836a57c3ef0cdff7994ec7bce27e968529e680a415d8',
     armv7l: 'cf0ff62b56328ae1c00e836a57c3ef0cdff7994ec7bce27e968529e680a415d8',
       i686: '8e11ee13f8672b8c8173fa633f179b87eec4aeece387a841be6c369d24729206',
     x86_64: '5bfbb058e3f3ed009066afb381dae0e8c5d7be3f20d9f9d063ad0227f1e62aba'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libsigsegv' # R
  depends_on 'wget2' => :build

  autotools_configure_options "--enable-gcc-warnings=no #{'--disable-year2038' unless ARCH == 'x86_64'}"
end
