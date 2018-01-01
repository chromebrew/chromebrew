require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.14'
  source_url 'https://www.kernel.org/pub/linux/docs/man-pages/man-pages-4.14.tar.xz'
  source_sha256 '3052b87898c313c089848a913e5cf44a0565cc4d21d94119ef6586d971f5c971'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "install"
  end

  def self.postinstall
    puts "Try 'man printf' to see if it works.".lightblue
  end
end
