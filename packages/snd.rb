require 'buildsystems/autotools'

class Snd < Autotools
  description 'Sound editor'
  homepage 'https://ccrma.stanford.edu/software/snd/'
  version '26.8'
  license 'Artistic'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ccrma.stanford.edu/software/snd/snd-#{version}.tar.gz"
  source_sha256 '68e9380da9b58a6da48a48e6bb93d6437eaa129efd3e213816f87a2313a88647'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8cf353d86272eb3091fd044cdce560f751b7914032b0de5f526f9270d01b2f89',
     armv7l: '8cf353d86272eb3091fd044cdce560f751b7914032b0de5f526f9270d01b2f89',
     x86_64: 'bda2de1a14de0c82be0df1b682a69ac665f2e809cc67ee052b119c0df9cc7c77'
  })

  depends_on 'alsa_lib' => :executable
  depends_on 'fftw' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gmp' => :executable
  depends_on 'gsl' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'jack' => :executable
  depends_on 'ladspa' => :executable
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libice' => :executable
  depends_on 'libogg' => :executable
  depends_on 'libsamplerate' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxft' => :executable
  depends_on 'libxpm' => :executable
  depends_on 'libxt' => :executable
  depends_on 'mesa' => :executable
  depends_on 'motif' => :executable
  depends_on 'mpc' => :executable
  depends_on 'mpfr' => :executable
  depends_on 'mpg123' => :executable
  depends_on 'scheme48' => :executable
  depends_on 'speexdsp' => :executable

  autotools_pre_configure_options "CFLAGS=' -Wno-implicit-function-declaration'"
  autotools_configure_options '--with-s7 \
    --with-ruby \
    --with-motif \
    --with-gui \
    --with-gl \
    --with-gl2ps \
    --with-gmp \
    --with-alsa \
    --with-jack \
    --with-ladspa'
end
