require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.5.1'
  source_url 'https://github.com/google/protobuf/archive/v3.5.1.tar.gz'
  source_sha256 '826425182ee43990731217b917c5c3ea7190cfda141af4869e6d4ad9085a740f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'unzip' => :build

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    system 'make check'
  end
end
