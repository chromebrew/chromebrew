require 'package'

class A52 < Package
  description 'liba52 is a free library for decoding ATSC A/52 streams.'
  homepage 'http://liba52.sourceforge.net/'
  version '0.7.4'
  compatibility 'all'
  source_url 'http://liba52.sourceforge.net/files/a52dec-0.7.4.tar.gz'
  source_sha256 'a21d724ab3b3933330194353687df82c475b5dfb997513eef4c25de6c865ec33'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/a52-0.7.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/a52-0.7.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/a52-0.7.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/a52-0.7.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f504acf9550dea90992fba392d7aedc43d872dd2bcba37cb08e369432a99e95',
     armv7l: '7f504acf9550dea90992fba392d7aedc43d872dd2bcba37cb08e369432a99e95',
       i686: '74340244a1e15054e0764f12fc36e7cae7b3d1ed44c7203555afa67500da5a43',
     x86_64: 'eb8a838b7b5284354f0e033f098e6c2270ea20eccf51df3ea5a93be6b2a4d56d',
  })

  def self.build
    system "./bootstrap"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
