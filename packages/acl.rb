require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.2.52-1'
  source_url 'https://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz'
  source_sha256 '179074bb0580c06c4b4137be4c5a92a701583277967acdb5546043c7874e0d23'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.52-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.52-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.52-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/acl-2.2.52-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '665f97de5ae62d224c789e447e59d4ee860b63c107f0e73fa8f5643da1ad8b6e',
     armv7l: '665f97de5ae62d224c789e447e59d4ee860b63c107f0e73fa8f5643da1ad8b6e',
       i686: 'bc8bd9f548810b7c682661a3c894ca234633b78534ddd5309bfc2a0311054dcd',
     x86_64: '41be0de4a728c698b10fbe686fdaa02d3cb98eb048d8253e164afaa3d6716a6a',
  })

  depends_on 'attr'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --libexecdir=#{CREW_LIB_PREFIX} \
            --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
