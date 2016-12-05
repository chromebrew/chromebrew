require 'package'

class Tcpdump < Package
  version '4.6.2'
  # Maintainer 'Bruno Fosados <bruno.fosados@gmail.com>'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/tcpdump-4.6.2-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: '3044ed1ac17cb1251fee3a22befaa04241477fac'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/tcpdump-4.6.2-src.tar.gz' 
  source_sha1 '7256c47e572229de8c92f070514c1f6e6bb691d4'

  depends_on 'buildessential'
  depends_on 'make'
  depends_on 'glibc'
  depends_on 'gcc'
  depends_on 'wireless_tools'

  def self.build
    system "make --prefix=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    puts "Please make sure to add '/usr/local/sbin' to your $PATH"
    puts 'Run this: sudo sed -i.original s?PATH=\"/usr/local/bin\:/usr/bin\:/bin\:\$\{PATH\}\"?PATH=\"/usr/local/bin\:/usr/bin\:/bin\:/usr/local/sbin\:\$\{PATH\}\"? /etc/profile'
    puts "This will fix you PATH variable, make sure you have rw enable on the partition"
  end
end
