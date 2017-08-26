require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.12'
  source_url 'https://www.kernel.org/pub/linux/docs/man-pages/man-pages-4.12.tar.xz'
  source_sha256 '6f6d79d991fed04e16e7c7a15705304b0b9d51de772c51c57428555039fbe093'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e675407d63878417c0c94bb7302a512e5b483b44cca6e7929aa7e2d47ebb8b37',
     armv7l: 'e675407d63878417c0c94bb7302a512e5b483b44cca6e7929aa7e2d47ebb8b37',
       i686: '1478fdbc9abc2c4a2bea07478d1491741af90ecca71bad282a273ce46001a2c4',
     x86_64: 'b6ca228781e27037ba75ce48d346d557b0fefdb07fa329db2c99dd31097adba0',
  })

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=/usr/local", "install"
    puts "Try 'man printf' to see if it works. You should have package 'mandb' installed.".lightblue
  end
end
