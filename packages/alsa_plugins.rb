require 'buildsystems/autotools'

class Alsa_plugins < Autotools
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.12'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alsa-project/alsa-plugins.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd89f01712334fe53f17861e86df16aaf6062facec1e23e4e78c037c06830cf05',
     armv7l: 'd89f01712334fe53f17861e86df16aaf6062facec1e23e4e78c037c06830cf05',
     x86_64: '01aa9a107de4ef378f3196eb4c10ad69a52f261cbcd36d65feda40f909d6c77a'
  })

  depends_on 'alsa_lib' # R
  depends_on 'dbus' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'jack' # R
  depends_on 'libsamplerate' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'speexdsp' # R

  run_tests
end
