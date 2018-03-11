require 'package'

class Xkbcomp < Package
  description 'Compile XKB keyboard'
  homepage 'https://www.x.org'
  version '1.4.1'
  source_url 'https://www.x.org/archive//individual/app/xkbcomp-1.4.1.tar.gz'
  source_sha256 '9cdae907b6e34f1f325f6311020126157037925877f323a880e0c9ecab9628f6'


  depends_on 'mesa'
  depends_on 'xcb_util'

    
  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \ 
            --with-xkb-config-root=#{CREW_LIB_PREFIX}/X11/xkb "
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_LIB_PREFIX}/X11/xkb"
  end
  
  def self.postinstall
    puts "xkb configuration files are located in #{CREW_LIB_PREFIX}/X11/xkb"
  end
end
