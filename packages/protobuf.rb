require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.6.1.3'
  source_url 'https://github.com/google/protobuf/archive/v3.6.1.3.tar.gz'
  source_sha256 '73fdad358857e120fd0fa19e071a96e15c0f23bb25f85d3f7009abfd4f264a2a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.6.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.6.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.6.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.6.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6c96a5727d6fbbc5ab2573b4c8abe375834be889e8faf6adc3c0a66e6fd09f9',
     armv7l: 'f6c96a5727d6fbbc5ab2573b4c8abe375834be889e8faf6adc3c0a66e6fd09f9',
       i686: '44593389c51701e0d9c4387f2d8daa34012c7ef8be32fea4cc0b445978ece14e',
     x86_64: 'bdd16eaf57b8745332d19d794e4d039885afc78e5ac4061503e3815096ea211f',
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
