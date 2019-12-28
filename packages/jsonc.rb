require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.13.1-20180305'
  source_url 'https://github.com/json-c/json-c/archive/json-c-0.13.1-20180305.tar.gz'
  source_sha256 '5d867baeb7f540abe8f3265ac18ed7a24f91fe3c5f4fd99ac3caba0708511b90'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '185e75bf352feb18166712f66783de119d304276f8af67f528d8ce2353d51103',
     armv7l: '185e75bf352feb18166712f66783de119d304276f8af67f528d8ce2353d51103',
       i686: 'e3333ce47bf5694de1dd4c4290938b4fd0be77dbb816afa299d1cf6304e4ed6c',
     x86_64: 'e8ca8ecbb00bc9e7cf7949d84cbaf1efdc53883002da46e3f48733e871617304',
  })


  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so.4", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
  end
end
