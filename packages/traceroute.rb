require 'package'

class Traceroute < Package
  version '2.0.21'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/traceroute-2.0.21-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: 'e126111971952ab49b4efbb145b6898e924a4575'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/traceroute-2.0.21-src.tar.gz' 
  source_sha1 '3acd1f8c275bd8d511e94e3c6f11fc5a280f0abb'

  depends_on 'buildessential'
  depends_on 'make'
  depends_on 'glibc'
  depends_on 'gcc'

  def self.build  
    system "make"
  end

  def self.install
    system "make", "prefix=#{CREW_DEST_DIR}", "install"
  end
end
