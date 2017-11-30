require 'package'

class Xf86driproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.1.1'
  source_url 'https://www.x.org/archive/individual/proto/xf86driproto-2.1.1.tar.gz'
  source_sha256 '18ff8de129b89fa24a412a1ec1799f8687f96c186c655b44b1a714a3a5d15d6c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86driproto-2.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xf86driproto-2.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xf86driproto-2.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86driproto-2.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b50e61fba22d3c78f2f65f5263aa1b922fe9858a9a4b3e5ad39db5117c5837c',
     armv7l: '7b50e61fba22d3c78f2f65f5263aa1b922fe9858a9a4b3e5ad39db5117c5837c',
       i686: '1e73a1c26eb143448522ef553b7be4b57471e03437bffc671f035460ec69ff94',
     x86_64: '434fd1676fa2f37eee07ea1f3ee8f4ded04cf5481b4c6c52c4215e248c008b71',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
