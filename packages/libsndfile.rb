require 'buildsystems/autotools'

class Libsndfile < Autotools
  description 'Libsndfile is a C library for reading and writing files containing sampled sound (such as MS Windows WAV and the Apple/SGI AIFF format) through one standard library interface.'
  homepage 'https://github.com/libsndfile/libsndfile'
  version '1.2.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/libsndfile/libsndfile/releases/download/1.2.2/libsndfile-1.2.2.tar.xz'
  source_sha256 '3799ca9924d3125038880367bf1468e53a1b7e3686a934f098b7e1d286cdb80e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e64d75555b4ff9383478bbe2588693ba41a024b281a64a8de47ee0cf03e0f2f6',
     armv7l: 'e64d75555b4ff9383478bbe2588693ba41a024b281a64a8de47ee0cf03e0f2f6',
       i686: '6d28a661b4ec8e0c85db4b57902aef01b253edfc633b3f9d791d53ffbbe31278',
     x86_64: 'be7071f6c235ed413cda0f328506a3661e513c7053882c8ef7fbe8426a9047e8'
  })

  depends_on 'alsa_lib' # R
  depends_on 'flac' # R
  depends_on 'glibc' # R
  depends_on 'libogg' # R
  depends_on 'libvorbis' # R
  depends_on 'nasm' => :build
  depends_on 'opus' # R
  depends_on 'speex' => :build
  depends_on 'sqlite' => :build
end
