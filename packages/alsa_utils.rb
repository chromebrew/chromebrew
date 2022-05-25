require 'package'

class Alsa_utils < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.9'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/alsa-project/alsa-utils/archive/v#{version}.tar.gz"
  source_sha256 'fde581549326489e9acb2b2d9ddcb146ee85a1698b817f7f4891f49c9f6fc11f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_utils/1.2.9_armv7l/alsa_utils-1.2.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_utils/1.2.9_armv7l/alsa_utils-1.2.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_utils/1.2.9_x86_64/alsa_utils-1.2.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7480e0f374071248b7bb7f3d5b4bf7b033f614303096707501836df0778aa0d9',
     armv7l: '7480e0f374071248b7bb7f3d5b4bf7b033f614303096707501836df0778aa0d9',
     x86_64: 'f419d655bbc28638878231d02d69e4e17c1dc045ec9625167c9c805ee96e7633'
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
