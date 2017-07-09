require 'package'

class Di < Package
  description '\'di\' is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'http://gentoo.com/di/'
  version '4.44'
  source_url 'https://gentoo.com/di/di-4.44.tar.gz'
  source_sha256 '963d00cadbf5a115ff31b31b0d6141be751c7b0a209e50990cb78e36d1a50320'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/di-4.44-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/di-4.44-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/di-4.44-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/di-4.44-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8afd4edc9ff3b1cf07ff24136db197b0ccd200cc513c058a49ae4bf1d7c6fd2',
     armv7l: 'd8afd4edc9ff3b1cf07ff24136db197b0ccd200cc513c058a49ae4bf1d7c6fd2',
       i686: '59031360f1daa4593cdb961864ed6357b30cbe393c6d83f80f4a38f8fff9fb92',
     x86_64: 'a233c27d5c1b70585a99806fd20f716e088b7f8fd5250a499b75d63a6cd863d3',
  })

  def self.build
    system "sed -i '40s,= ,= $(DESTDIR)/,' Makefile" # set correct bin path
    system "sed -i '44s,= ,= $(DESTDIR)/,' Makefile" # add destdir to man path
    system "sed -i '61s,share/,,' Makefile"          # remove share segment
    system "sed -i '52s/root/chronos/' Makefile"     # set correct owner
    system "sed -i '53s/bin/chronos/' Makefile"      # set correct group
    system "CC=gcc prefix=/usr/local make -e"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end
