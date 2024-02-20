require 'package'

class Alsa_utils < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.11'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/alsa-project/alsa-utils/archive/v#{version}.tar.gz"
  source_sha256 '978961153fa8ca4c783c93767e7054d0dc1fb42ef6f1008040ca71363d0f4d35'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f702ad52afed8235203c6155c5670bb525f88a51d0941e22231fd0b1d277a34',
     armv7l: '5f702ad52afed8235203c6155c5670bb525f88a51d0941e22231fd0b1d277a34',
     x86_64: '5ef82a21da013de424f882f7796ca215c14e46503420a51747cb784f98694dbf'
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

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS}"
  end

  def self.check
    # This takes several hours to run!
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
