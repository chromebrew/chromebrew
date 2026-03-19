require 'buildsystems/autotools'

class Portaudio < Autotools
  description 'Free, cross-platform, open-source, audio I/O library.'
  homepage 'https://portaudio.com/'
  version '19.7.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/PortAudio/portaudio.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55a5fedd5654b53eaf8115f017038997900d127f2b774a973bab11342c34a66b',
     armv7l: '55a5fedd5654b53eaf8115f017038997900d127f2b774a973bab11342c34a66b',
     x86_64: '3aa035aaa1b34eb5643779b99acc297aa6012d9053d6637d429a2745adf48f56'
  })

  depends_on 'alsa_lib' # R
  depends_on 'glibc' # R
  depends_on 'jack' # R
end
