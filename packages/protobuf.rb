require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.9.2'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf/archive/v3.9.2.tar.gz'
  source_sha256 '1fbf1c2962af287607232b2eddeaec9b4f4a7a6f5934e1a9276e9af76952f7e0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.9.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.9.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.9.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.9.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b3f225eebd40ce365b40d98ea7eaef74705a2801f50c83a4bc84cdd7f0a5cf6',
     armv7l: '7b3f225eebd40ce365b40d98ea7eaef74705a2801f50c83a4bc84cdd7f0a5cf6',
       i686: '11088f5231b60bddcb902bfc9b72363d67c668384063f31e24a37244cc34cf60',
     x86_64: '7e6016f3c4b2c50db0e7b285a3f4fbc384b80f9cf367a68fda8de15d4fb8fcc3',
  })

  def self.build
    system './autogen.sh'
    system "./configure",
           "--disable-static",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    #system 'make check'
  end
end
