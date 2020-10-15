require 'package'

class Abcde < Package
  description 'Grab an entire CD and compress it to Ogg/Vorbis, MP3, FLAC, AAC, Ogg/Speex and/or MPP/MP+(Musepack) format.'
  homepage 'https://abcde.einval.com/wiki/'
  version '2.9.3'
  compatibility 'all'
  source_url 'https://abcde.einval.com/download/abcde-2.9.3.tar.gz'
  source_sha256 '046cd0bba78dd4bbdcbcf82fe625865c60df35a005482de13a6699c5a3b83124'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,prefix = /usr/local,prefix = #{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,sysconfdir = /etc,sysconfdir = #{CREW_DEST_PREFIX}/etc,' Makefile"
  end

  def self.install
    system "make install"
  end
end
