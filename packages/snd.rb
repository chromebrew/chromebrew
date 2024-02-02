require 'buildsystems/autotools'

class Snd < Autotools
  description 'Sound editor'
  homepage 'https://ccrma.stanford.edu/software/snd/'
  version '24.1'
  license 'TCL/TK'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ccrma.stanford.edu/software/snd/snd-24.1.tar.gz'
  source_sha256 '842e8675d623043ea9e33c070f77c2bd964bc2946234a39be9a687b2d4610353'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '482dceabb30e90fc3b9a8fb1edf2be801d124d01780024e875247cc411c73c06',
     armv7l: '482dceabb30e90fc3b9a8fb1edf2be801d124d01780024e875247cc411c73c06',
     x86_64: '6c0062b078ee1a2928e281b3dcc484eb42cf464b14a2e621f4ccbcd1a18f2cb5'
  })

  depends_on 'alsa_lib'
  depends_on 'gl2ps'
  depends_on 'gmp'
  depends_on 'gsl'
  depends_on 'gtk3'
  depends_on 'jack'
  depends_on 'ladspa'
  depends_on 'libogg'
  depends_on 'libxpm'
  depends_on 'mesa'
  depends_on 'motif'
  depends_on 'mpg123'
  depends_on 'scheme48'
  depends_on 'speexdsp'
  depends_on 'pulseaudio'

  configure_options '--with-s7 \
    --with-ruby \
    --with-motif \
    --with-gui \
    --with-gl \
    --with-gl2ps \
    --with-gmp \
    --with-alsa \
    --with-jack \
    --with-pulseaudio \
    --with-ladspa'
end
