require 'package'

class Abcde < Package
  description 'Grab an entire CD and compress it to Ogg/Vorbis, MP3, FLAC, AAC, Ogg/Speex and/or MPP/MP+(Musepack) format.'
  homepage 'https://abcde.einval.com/wiki/'
  version '2.8.1'
  source_url 'https://abcde.einval.com/download/abcde-2.8.1.tar.gz'
  source_sha256 'e49c71d7ddcd312dcc819c3be203abd3d09d286500ee777cde434c7881962b39'

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
