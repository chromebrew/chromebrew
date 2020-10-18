require 'package'

class Abcde < Package
  description 'Grab an entire CD and compress it to Ogg/Vorbis, MP3, FLAC, AAC, Ogg/Speex and/or MPP/MP+(Musepack) format.'
  homepage 'https://abcde.einval.com/wiki/'
  version '2.9.3'
  compatibility 'all'
  source_url 'https://abcde.einval.com/download/abcde-2.9.3.tar.gz'
  source_sha256 '046cd0bba78dd4bbdcbcf82fe625865c60df35a005482de13a6699c5a3b83124'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dde5336b912d62d86b8fc15394305fe9c3971d94067c156bccd7325d1c50cc85',
     armv7l: 'dde5336b912d62d86b8fc15394305fe9c3971d94067c156bccd7325d1c50cc85',
       i686: 'd6a704ec69f3b1bd4e1308bfa81f9756d838971556ee76fff6717692b16cc63a',
     x86_64: '5fd40b457b1f1474e52d133a134b845e4460e62f51457400b91e4134c8f9da18',
  })

  def self.build
    system "sed -i 's,prefix = /usr/local,prefix = #{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,sysconfdir = /etc,sysconfdir = #{CREW_DEST_PREFIX}/etc,' Makefile"
  end

  def self.install
    system "make install"
  end
end
