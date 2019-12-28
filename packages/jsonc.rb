require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.13.1-20180305'
  source_url 'https://github.com/json-c/json-c/archive/json-c-0.13.1-20180305.tar.gz'
  source_sha256 '5d867baeb7f540abe8f3265ac18ed7a24f91fe3c5f4fd99ac3caba0708511b90'

  binary_url ({
  })
  binary_sha256 ({
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
