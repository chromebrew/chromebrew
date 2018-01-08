require 'package'

class Abcde < Package
  description 'Grab an entire CD and compress it to Ogg/Vorbis, MP3, FLAC, AAC, Ogg/Speex and/or MPP/MP+(Musepack) format.'
  homepage 'https://abcde.einval.com/wiki/'
  version '2.8.1'
  source_url 'https://abcde.einval.com/download/abcde-2.8.1.tar.gz'
  source_sha256 'e49c71d7ddcd312dcc819c3be203abd3d09d286500ee777cde434c7881962b39'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/abcde-2.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1df59dce7cb4f2c5d232ad192ba17b4a0aa64bbe6cf262faf00794e706a160a',
     armv7l: 'e1df59dce7cb4f2c5d232ad192ba17b4a0aa64bbe6cf262faf00794e706a160a',
       i686: '838a40a6bfbf7a0e848b091f9ee83158a1f5436183b86789cb71b8b8c4fa1f08',
     x86_64: '6177e24acfeecf223a4d3b3c86e47fcbcae90006f23df0cf9573b1a75c2e4c4a',
  })

  def self.build
    system "sed -i 's,prefix = /usr/local,prefix = #{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,sysconfdir = /etc,sysconfdir = #{CREW_DEST_PREFIX}/etc,' Makefile"
  end

  def self.install
    system "make install"
  end
end
