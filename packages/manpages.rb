require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.15'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-4.15.tar.xz'
  source_sha256 'ce707f2a28ee49496595af163d0cac24a9b7b88ab9aa5e5057abaa3d03cec106'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c566190f3dae32ca9df24bc053c1b8754a26088c36da4355c1aab9d28e6e15f4',
     armv7l: 'c566190f3dae32ca9df24bc053c1b8754a26088c36da4355c1aab9d28e6e15f4',
       i686: 'f523d513517f1be4132d0023bbad1492c91822b48d590f93982306aeed9f5d68',
     x86_64: '13b7282b0c45b1c0ae81af86bab2cbdf31c13cc923a1fb248130c62e7ea89fa1',
  })

  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "install"
  end

  def self.postinstall
    puts "Try 'man printf' to see if it works.".lightblue
  end
end
