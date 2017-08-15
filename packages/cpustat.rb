require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'http://kernel.ubuntu.com/~cking/cpustat/'
  version '0.02.03'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/cpustat/cpustat-0.02.03.tar.gz'
  source_sha256 '8e48cbd6927b9060a59cd278bb855f6fcdb773ff5ff919a1f75c086c94b4c1d0'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/cpustat-0.02.03-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/cpustat-0.02.03-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/cpustat-0.02.03-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/cpustat-0.02.03-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3512fe1d54b69cc47830c99ea89fa6851dc14a936c942c1087d49bd9c4a1643c',
     armv7l: '3512fe1d54b69cc47830c99ea89fa6851dc14a936c942c1087d49bd9c4a1643c',
       i686: 'e108e8981bcfa369dbeb450ef2fe5f60adf752ba7bd6b45e3670778fd871089a',
     x86_64: 'fd4dc76c596c68617c9ef91cefc17ce5394e52227754968a6f699548439c08e7',
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
