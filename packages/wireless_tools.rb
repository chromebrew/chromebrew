require 'package'

class Wireless_tools < Package
  version '0.29'
  # Maintainer 'Bruno Fosados <bruno.fosados@gmail.com>'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/wireless_tools.29-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: 'cc19280a5edbfa912c392c2c724b73d33dc55236'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/wireless_tools.29-src.tar.gz' 
  source_sha1 '22040ac1497f4c5f8ddeca365591b01ae3475710'

  depends_on 'buildessential'
  depends_on 'make'
  depends_on 'glibc'
  depends_on 'gcc'

  def self.build  
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_DIR}", "install"
    system "echo", "Please make sure to add '/usr/local/sbin' to your $PATH"
    system "echo run this: 'sudo sed -i.original s?PATH=\"/usr/local/bin\:/usr/bin\:/bin\:\$\{PATH\}\"?PATH=\"/usr/local/bin\:/usr/bin\:/bin\:/usr/local/sbin\:\$\{PATH\}\"? 
/etc/profile' \nBut make sure you have rw enable on the partition"
  end
end
