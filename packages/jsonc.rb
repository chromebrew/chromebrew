require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.13.1-20180305-1'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c/archive/json-c-0.13.1-20180305.tar.gz'
  source_sha256 '5d867baeb7f540abe8f3265ac18ed7a24f91fe3c5f4fd99ac3caba0708511b90'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13.1-20180305-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c00bac86e26ee85be838fd5ab2ac422f144a86d7049be13809e389607e3ca97b',
     armv7l: 'c00bac86e26ee85be838fd5ab2ac422f144a86d7049be13809e389607e3ca97b',
       i686: 'c72d10147176e9ab64a91d933b8c4d2c6c9e62b95a63f3edf17cb97bbf5a066e',
     x86_64: 'a39d059131cb8f1fa0b436199433f634d2f991594c2e94fe03e5388230637fc7',
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
