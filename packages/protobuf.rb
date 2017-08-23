require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.3.0-1'
  source_url 'https://github.com/google/protobuf/archive/v3.3.0.tar.gz'
  source_sha256 '94c414775f275d876e5e0e4a276527d155ab2d0da45eed6b7734301c330be36e'

  depends_on 'automake'
  depends_on 'libtool'

  def self.build
    system './autogen.sh'
    system "./configure --prefix=/usr/local --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    system 'make check'
  end
end
