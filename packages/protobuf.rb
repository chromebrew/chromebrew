require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.6.1.3'
  source_url 'https://github.com/google/protobuf/archive/v3.6.1.3.tar.gz'
  source_sha256 '73fdad358857e120fd0fa19e071a96e15c0f23bb25f85d3f7009abfd4f264a2a'

  binary_url ({
  })
  binary_sha256 ({
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
    system 'make check'
  end
end
