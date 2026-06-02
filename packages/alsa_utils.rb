require 'buildsystems/autotools'

class Alsa_utils < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.16'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alsa-project/alsa-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b559d7dbbff71cb04fc6639e623bb3648d6055c73f7c6ed3dd7ed38ad58dc70',
     armv7l: '6b559d7dbbff71cb04fc6639e623bb3648d6055c73f7c6ed3dd7ed38ad58dc70',
     x86_64: 'eb958ba2ba71b5f41cbe19a557a756a204b0d8ad095362efcaf63a3c1c0d2812'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'cras' => :logical
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libsamplerate' => :executable
  depends_on 'ncurses' => :executable

  def self.patch
    # downloader 'https://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess', 'SKIP'
    # downloader 'https://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub', 'SKIP'
    system 'autoreconf -fiv'
  end
end
