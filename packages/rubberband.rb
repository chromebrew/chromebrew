require 'buildsystems/meson'

class Rubberband < Meson
  description 'Rubber Band Library is a high quality software library for audio time-stretching and pitch-shifting.'
  homepage 'https://breakfastquay.com/rubberband/'
  version '3.3.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://breakfastquay.com/files/releases/rubberband-3.3.0.tar.bz2'
  source_sha256 'd9ef89e2b8ef9f85b13ac3c2faec30e20acf2c9f3a9c8c45ce637f2bc95e576c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30db5404665bb687280f3a90748260dcc4fe78abdb591dfdb1a713ef444f7ec6',
     armv7l: '30db5404665bb687280f3a90748260dcc4fe78abdb591dfdb1a713ef444f7ec6',
     x86_64: 'd280cbc2f5f677b739dfc6ba1fa5739f0342635eb629bf7848d654dd9bbda667'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ladspa' => :build
  depends_on 'libsamplerate' => :build
  depends_on 'libsndfile' # R
  depends_on 'vamp_sdk' # R
end
