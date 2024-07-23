require 'package'

class Jack < Package
  description 'JACK (JACK Audio Connection Kit) refers to an API that provides a basic infrastructure for audio applications to communicate with each other and with audio hardware.'
  homepage 'https://jackaudio.org/'
  version '1.9.21'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/jackaudio/jack2/archive/v#{version}.tar.gz"
  source_sha256 '8b044a40ba5393b47605a920ba30744fdf8bf77d210eca90d39c8637fe6bc65d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6185f7f83066b59da49430902bf6cb99d3c69922e41d96ef18456bd27fdedaa6',
     armv7l: '6185f7f83066b59da49430902bf6cb99d3c69922e41d96ef18456bd27fdedaa6',
     x86_64: 'b4c6d93821733e2f834e460ce7ca206df2ef19e2480338a174adc15bc95cf4b2'
  })

  depends_on 'dbus'
  depends_on 'alsa_lib'
  depends_on 'libdb'
  depends_on 'libsndfile'
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'opus' # R

  def self.patch
    # Set the correct python executable path.
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' waf"
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' dbus/jack_control"
  end

  def self.build
    system "./waf configure \
      --dbus \
      --classic \
      --db=yes \
      --alsa=yes \
      --sndfile=yes \
      --autostart=none \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX}"
    system './waf build'
  end

  def self.install
    system "./waf install --destdir=#{CREW_DEST_DIR}"
  end
end
