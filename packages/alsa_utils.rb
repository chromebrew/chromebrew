require 'buildsystems/autotools'

class Alsa_utils < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.15'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alsa-project/alsa-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4f83222936a93eed6b50f84251adb33d22a032edc76ddeacaae0d4f1faade21',
     armv7l: 'c4f83222936a93eed6b50f84251adb33d22a032edc76ddeacaae0d4f1faade21',
     x86_64: '0d32ba068b347894e8c6d2c43c71852ca544fb839bcf8b00529b3da916f93b5b'
  })

  depends_on 'alsa_lib' # R
  depends_on 'cras' # L
  depends_on 'glibc' # R
  depends_on 'libsamplerate' # R
  depends_on 'ncurses' # R

  def self.patch
    # downloader 'https://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess', 'SKIP'
    # downloader 'https://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub', 'SKIP'
    system 'autoreconf -fiv'
  end
end
