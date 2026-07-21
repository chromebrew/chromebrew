require 'buildsystems/autotools'

class Pcaudiolib < Autotools
  description 'PCaudiolib is a portable C audio library.'
  homepage 'https://github.com/espeak-ng/pcaudiolib'
  version '1.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/espeak-ng/pcaudiolib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ea3ccddab1d25c0bb5fc3e2923990647ca9d4a5012be1ffafb225a101446c4b',
     armv7l: '9ea3ccddab1d25c0bb5fc3e2923990647ca9d4a5012be1ffafb225a101446c4b',
       i686: 'e7f1096a5c92622f0e78585540304fb6361f5980a9cf8faf195bd833272ef0a4',
     x86_64: 'e13c7347e62918f5b1868563af23649f6db4784ea95a92d52ac3f8a81ac6b1cf'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'pulseaudio' => :library unless ARCH.eql?('i686')

  autotools_configure_options ' \
    --with-pulseaudio \
    --with-alsa \
    --without-qsa \
    --without-coreaudio \
    --without-oss'
end
