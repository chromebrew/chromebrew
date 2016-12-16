require 'package'

class Readline < Package
  version '6.3'

  binary_url({		
     armv7l: "https://dl.dropboxusercontent.com/s/kut6emhlda9pbc9/dummy-1.0.0-chromeos-armv7l.tar.gz",		
     x86_64: "http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz"		
   })		
   binary_sha1({		
     armv7l: "049db60338a74d798e72afabe05097f3a4c4f7cd",		
     x86_64: '017b92dc7fd4e636a2b5c9265a77ccc05798c9e1'		
   })
  
  depends_on 'buildessential' #until binary for i686 provided

  def self.build
    system "./configure"
    system "CC='gcc' make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
