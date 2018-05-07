require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'http://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.04'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.04.tar.gz'
  source_sha256 '10fbe56a17161094818be779127f635dc65262b305e5a5614d9e46536a9d92c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cpustat-0.02.04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '20a5e9e09f2e3bd704f17c14b7f260ccbeac1111418cc837e904c05a700dae67',
     armv7l: '20a5e9e09f2e3bd704f17c14b7f260ccbeac1111418cc837e904c05a700dae67',
       i686: '21670c81a422830e149287936be6c10e58bcbb39fe9c94810677ba8f93949f5d',
     x86_64: 'b505ca257198a54ee256f85fee63fb14d2275572b37af287aad8a47d1ba2b6b8',
  })

  def self.build
    system "sed -i 's,sbin,bin,' Makefile"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s,$, -I#{CREW_PREFIX}/include/ncurses,' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
