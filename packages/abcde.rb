require 'package'

class Abcde < Package
  description 'Grab an entire CD and compress it to Ogg/Vorbis, MP3, FLAC, AAC, Ogg/Speex and/or MPP/MP+(Musepack) format.'
  homepage 'https://abcde.einval.com/wiki/'
  version '2.9.1'
  compatibility 'all'
  source_url 'https://abcde.einval.com/download/abcde-2.9.1.tar.gz'
  source_sha256 '70ec6e06b791115fbe88dee313f58f691f9b559ee992f2af5ed64fe6ad2e55d7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '41d0e99a8e7614ac6f2a4b0b24e2e2bf93b138fc075dfae7404b4a9245bea514',
     armv7l: '41d0e99a8e7614ac6f2a4b0b24e2e2bf93b138fc075dfae7404b4a9245bea514',
       i686: 'd904d510107cd8b749ada9c85da0f059bdaa8cd0c755201df13f0f4da6f572d5',
     x86_64: 'eb965e6d641bd482b7e0789e5231b7555ca28dd2dbc1ef736769f8084355f31a',
  })

  def self.build
    system "sed -i 's,prefix = /usr/local,prefix = #{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,sysconfdir = /etc,sysconfdir = #{CREW_DEST_PREFIX}/etc,' Makefile"
  end

  def self.install
    system "make install"
  end
end
