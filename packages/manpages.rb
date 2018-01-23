require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.14'
  source_url 'https://www.kernel.org/pub/linux/docs/man-pages/man-pages-4.14.tar.xz'
  source_sha256 '3052b87898c313c089848a913e5cf44a0565cc4d21d94119ef6586d971f5c971'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f4f331b25927739dc3ac24a73e53b5923653ade8343c17a6e183743ee1caee26',
     armv7l: 'f4f331b25927739dc3ac24a73e53b5923653ade8343c17a6e183743ee1caee26',
       i686: '993d39bf63c55fbf212ad002468356d8a788375479bc2605bdcd577cf9b176c0',
     x86_64: 'f3eed4ef25444bf1bdb65c852766fbe4ba541b5f6bc7b266bd807300515d0e40',
  })

  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "install"
  end

  def self.postinstall
    puts "Try 'man printf' to see if it works.".lightblue
  end
end
