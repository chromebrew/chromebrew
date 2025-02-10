require 'buildsystems/autotools'

class Alsa_utils < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.12'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alsa-project/alsa-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adf3a2732a82eda1e9d4c62e5c71a6d15bf430bc0db13caf0b23213793c3355f',
     armv7l: 'adf3a2732a82eda1e9d4c62e5c71a6d15bf430bc0db13caf0b23213793c3355f',
     x86_64: '319eafbd0afed0942f9da2a1e28d6e4d8d2d4fe0ba2fd9d797ad9d274d8ac6b7'
  })

  depends_on 'alsa_lib' # R
  depends_on 'cras' # L
  depends_on 'glibc' # R
  depends_on 'libsamplerate' # R
  depends_on 'ncurses' # R

  def self.patch
    downloader 'https://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess', 'SKIP'
    downloader 'https://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub', 'SKIP'
    system 'autoreconf -fiv'
  end
end
