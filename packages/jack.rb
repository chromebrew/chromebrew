require 'package'

class Jack < Package
  description 'JACK (JACK Audio Connection Kit) refers to an API that provides a basic infrastructure for audio applications to communicate with each other and with audio hardware.'
  homepage 'https://jackaudio.org/'
  @_ver = '1.9.17'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/jackaudio/jack2/archive/v#{@_ver}.tar.gz"
  source_sha256 '38f674bbc57852a8eb3d9faa1f96a0912d26f7d5df14c11005ad499c8ae352f2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.17-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.17-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.17-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '790e0a69c09a6e87e094f8cd8cf2bc6627f8fbb3c7b4718f35b466e04fb13d1a',
     armv7l: '790e0a69c09a6e87e094f8cd8cf2bc6627f8fbb3c7b4718f35b466e04fb13d1a',
       i686: '0946a39b386d3f4434e1a4d735342918537f302acfba6641ed888e76c058fae0',
     x86_64: 'f8cf79f4a8402e8c4cdcfe8d31cc9357ba3404d5bfe57a8dea7fac4ec12bd091'
  })

  depends_on 'dbus'
  depends_on 'alsa_lib'
  depends_on 'libdb'
  depends_on 'libsndfile'

  def self.patch
    # Set the correct python executable path.
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' waf"
  end

  def self.build
    system "env CFLAGS=-fno-stack-protector \
      ./waf configure \
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
