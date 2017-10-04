require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.3.0-1'
  source_url 'https://github.com/google/protobuf/archive/v3.3.0.tar.gz'
  source_sha256 '94c414775f275d876e5e0e4a276527d155ab2d0da45eed6b7734301c330be36e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.3.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.3.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.3.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.3.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2f8b0c4fa32e4675115c93ecf483fb014ed1191b8fb5cfa81c898b0f5d54aec1',
     armv7l: '2f8b0c4fa32e4675115c93ecf483fb014ed1191b8fb5cfa81c898b0f5d54aec1',
       i686: '746b00166eac38ea368bc5954aca8b017c7a4182f54143bb15463dcaf43839fc',
     x86_64: 'd96734af335416a6e78fefaa86c39c51baca17a3b5486f4d75022ee11f2aa1f2',
  })

  depends_on 'automake' => :build
  depends_on 'libtool'  => :build

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
