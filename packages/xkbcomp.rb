require 'package'

class Xkbcomp < Package
  description 'Compile XKB keyboard'
  homepage 'https://www.x.org'
  version '1.4.1'
  source_url 'https://www.x.org/archive//individual/app/xkbcomp-1.4.1.tar.gz'
  source_sha256 '9cdae907b6e34f1f325f6311020126157037925877f323a880e0c9ecab9628f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xkbcomp-1.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ed85e49b397d30d573fe2f257e4b0ce15a2a9251b5ee5b71fb8e2f6ae67d7b4',
     armv7l: '7ed85e49b397d30d573fe2f257e4b0ce15a2a9251b5ee5b71fb8e2f6ae67d7b4',
       i686: 'da328a3d2e94c439548b87d9a052dee48a8c8fd76b1ceb07935dd7c285fb8afa',
     x86_64: 'ef2d4699d40b67b73d44691ebc83f722a70374ec5849e11e56525606ddf04e83',
  })

  depends_on 'mesa'
  depends_on 'xcb_util'
    
  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
  def self.postinstall
    puts "xkb configuration files are located in #{CREW_PREFIX}/share/X11/xkb".lightblue
  end
end
