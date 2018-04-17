require 'package'

class Protobuf < Package
  description 'Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.'
  homepage 'https://developers.google.com/protocol-buffers/'
  version '3.5.1'
  source_url 'https://github.com/google/protobuf/archive/v3.5.1.tar.gz'
  source_sha256 '826425182ee43990731217b917c5c3ea7190cfda141af4869e6d4ad9085a740f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/protobuf-3.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c9f90e5821643761acf7aabb0e60a9d2d295071b1f3a06664e78ff071483edb3',
     armv7l: 'c9f90e5821643761acf7aabb0e60a9d2d295071b1f3a06664e78ff071483edb3',
       i686: '9df9e1d3deb47a836193f72385eaf383fd2a49e0246e0259fea856a59290097c',
     x86_64: '5da67b574e7df6c9e58b2bcee98b3b78cf7c95d6458350a3a1036981b0ad4f99',
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
