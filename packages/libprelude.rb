require 'package'

class Libprelude < Package
  description 'Prelude is a Universal "Security Information & Event Management" (SIEM) system.'
  homepage 'https://www.prelude-siem.org/'
  version '4.1.0'
  compatibility 'all'
  source_url 'https://www.prelude-siem.org/attachments/download/831/libprelude-4.1.0.tar.gz'
  source_sha256 '21ee5bee2fc4136903c606ad7891927b7b32a29e92ca7e418ac458823951562d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libprelude-4.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libprelude-4.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libprelude-4.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libprelude-4.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb7139c322d79adb0dfa2a8c87b63d0b496c6485afed3a10dd48fdfe93cdf6c6',
     armv7l: 'cb7139c322d79adb0dfa2a8c87b63d0b496c6485afed3a10dd48fdfe93cdf6c6',
       i686: '32ddcbd6646843c224450cb45a018873f89b4c1f66a4addef5dcf15318d9d953',
     x86_64: 'f7642b1ffb9a0b5ee5c22a3f1345fbc0ff8b7e334a9839c7d24b7108fd069806',
  })

  depends_on 'six' => :build

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
