require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.16'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-4.16.tar.xz'
  source_sha256 '47ffcc0d27d50e497e290b27e8d76dbed4550db14c881f25b771bcaf28354db4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b35bc3788192c55de31e28d0fd1105e3e9e1e7285f49c837aaef76239bd8df80',
     armv7l: 'b35bc3788192c55de31e28d0fd1105e3e9e1e7285f49c837aaef76239bd8df80',
       i686: '99aec8751774cccc93675cb93b95c1023e08a6a9612f9da0d1fb63adfdae26fe',
     x86_64: '2954a0b3aad52ea863273182dca083c0e3417ad4ffb3ecf8480ea83c69d7b0c7',
  })

  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "install"
  end

  def self.postinstall
    puts "Try 'man printf' to see if it works.".lightblue
  end
end
