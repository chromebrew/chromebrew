require 'package'

class Libfs < Package
  description 'X.org library interface to the X Font Server.'
  homepage 'http://www.x.org'
  version '1.0.7'
  source_url 'https://www.x.org/archive/individual/lib/libFS-1.0.7.tar.gz'
  source_sha256 '91bf1c5ce4115b7dbf4e314fdbee54052708e8f7b6a2ec6e82c309bcbe40ef3d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfs-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6c1e8ecfddad8ccff8277b6b252965afd7275e99c3e86f2bdb20d39272fc134',
     armv7l: 'f6c1e8ecfddad8ccff8277b6b252965afd7275e99c3e86f2bdb20d39272fc134',
       i686: '3e54b814e5b9d208a48b4ac097076d0f956b32943ac2f45da5ac551934ba7f42',
     x86_64: '1092805d6bada562543bc23fb5395d675c6a9c00cba4387ba7f97b42df0d9463',
  })

  depends_on 'xproto'
  depends_on 'fontsproto'
  depends_on 'libxtrans'
  depends_on 'util_macros'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end