require 'package'

class Libndp < Package
  description 'Library for Neighbor Discovery Protocol'
  homepage 'http://libndp.org/'
  version '1.7-3fc2'
  compatibility 'all'
  source_url 'https://github.com/jpirko/libndp/archive/3fc2ed78edb5deae0381d022bedc22ffd00d50cb.zip'
  source_sha256 '53fd7da8fc840900238f1699e98a7e3e60cd6c68489015303e84b19c9dd2bb3a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libndp-1.7-3fc2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libndp-1.7-3fc2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libndp-1.7-3fc2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libndp-1.7-3fc2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cd1c2dc1ba0d66e86f335a9003a21c5cdb83f617b95fc9cee3f47cedaac44776',
     armv7l: 'cd1c2dc1ba0d66e86f335a9003a21c5cdb83f617b95fc9cee3f47cedaac44776',
       i686: '362f65de766cd934bf1e99db75ffdac99715b9a05e90f97b89784ad6d952f369',
     x86_64: '17fb4275c5ef57c0c5e058721381fa4f836fae81076114ebd81dea0e0facaa41'
  })

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
    LDFLAGS='-pipe -flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --sysconfdir=#{CREW_PREFIX}/etc \
    --localstatedir=/var \
    --libexecdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
