require 'buildsystems/autotools'

class Alsa_utils < Autotools
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.15.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alsa-project/alsa-utils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdff982719bb2299f7f77b83fec785f1bd01230bd14eae34ebf06e4826795014',
     armv7l: 'bdff982719bb2299f7f77b83fec785f1bd01230bd14eae34ebf06e4826795014',
     x86_64: '3fa468373488691d3823beec0b5200153fafd194cf9ef49d37e9d5111c2e710a'
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
