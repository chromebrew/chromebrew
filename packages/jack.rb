require 'package'

class Jack < Package
  description 'JACK (JACK Audio Connection Kit) refers to an API that provides a basic infrastructure for audio applications to communicate with each other and with audio hardware.'
  homepage 'https://jackaudio.org/'
  version '1.9.14'
  source_url 'https://github.com/jackaudio/jack2/releases/download/v1.9.14/v1.9.14.tar.gz'
  source_sha256 'a20a32366780c0061fd58fbb5f09e514ea9b7ce6e53b080a44b11a558a83217c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jack-1.9.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '347c09ba7eb56e45ab222de5aebbc75ea6c9bbf85c59bf1da3cb33a87762a0c7',
     armv7l: '347c09ba7eb56e45ab222de5aebbc75ea6c9bbf85c59bf1da3cb33a87762a0c7',
       i686: '8b855311f24cb179be23371066b8f8917589af2ac364ce8a70af145f5e8b86a1',
     x86_64: '85bb228bd5f60b72b377ca99bd22464292d3cf05f7e5e92d433482117abdeafd',
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
    system './waf',
           'configure',
           '--dbus',
           '--classic',
           '--db=yes',
           '--alsa=yes',
           '--sndfile=yes',
           '--autostart=none',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system './waf build'
  end

  def self.install
    system "./waf install --destdir=#{CREW_DEST_DIR}"
  end
end
