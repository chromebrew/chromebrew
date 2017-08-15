require 'package'

class Gc < Package
  description 'A garbage collector for C and C++.'
  homepage 'http://www.hboehm.info/gc/'
  version '7.6.0'
  source_url 'http://www.hboehm.info/gc/gc_source/gc-7.6.0.tar.gz'
  source_sha256 'a14a28b1129be90e55cd6f71127ffc5594e1091d5d54131528c24cd0c03b7d90'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gc-7.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gc-7.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/gc-7.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/gc-7.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd962f0e9693e93b7915865e592a6af653afc311117e64164550d0e6de459cacf',
     armv7l: 'd962f0e9693e93b7915865e592a6af653afc311117e64164550d0e6de459cacf',
       i686: '7419f6b39d300976cfb8d40692b7e446b4bd354198a8b6dfb8fd98e88255bb66',
     x86_64: 'f7a3d7f2d3471f2e26fd5df087cd85f99ee959aebd81c47ebc14bb5f10a0a3df',
  })

  depends_on 'libatomic_ops'
  depends_on 'libtool'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "libtool --finish /usr/local/lib"
  end
end
