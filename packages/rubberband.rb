require 'buildsystems/meson'

class Rubberband < Meson
  description 'Rubber Band Library is a high quality software library for audio time-stretching and pitch-shifting.'
  homepage 'https://breakfastquay.com/rubberband/'
  version '4.0.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://breakfastquay.com/files/releases/rubberband-#{version}.tar.bz2"
  source_sha256 'af050313ee63bc18b35b2e064e5dce05b276aaf6d1aa2b8a82ced1fe2f8028e9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7794865a06c44c6c5404ab90b1788672ed205b7a6f5e0490255e26a574b4dc64',
     armv7l: '7794865a06c44c6c5404ab90b1788672ed205b7a6f5e0490255e26a574b4dc64',
     x86_64: '8cf64e3fa806fd38358820d710c409a217ac3079b976fe7f62b33be72fe24d20'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ladspa' => :build
  depends_on 'libsamplerate' => :build
  depends_on 'libsndfile' => :executable
  depends_on 'vamp_sdk' => :library
end
