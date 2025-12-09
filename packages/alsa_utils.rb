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
    aarch64: 'f1ac69ee7f4aeca6f6dd2be7d4cbb32ef548810171d04984d7644e71c1673933',
     armv7l: 'f1ac69ee7f4aeca6f6dd2be7d4cbb32ef548810171d04984d7644e71c1673933',
     x86_64: '88b34e5a7d3050c87fd3b39be746a728aa094a37dfbd90559d1dffdfe9624965'
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
