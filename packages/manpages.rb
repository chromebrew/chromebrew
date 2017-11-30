require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.13'
  source_url 'https://www.kernel.org/pub/linux/docs/man-pages/man-pages-4.13.tar.xz'
  source_sha256 'd5c005c5b653248ab6680560de00ea8572ff39e48a57bd5be1468d986a0631bf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/manpages-4.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '97ddc239d22e2d9651d531d16872cfbcbc4f1fb9a9cc98379ce3141c2f088872',
     armv7l: '97ddc239d22e2d9651d531d16872cfbcbc4f1fb9a9cc98379ce3141c2f088872',
       i686: '744a2625e56519fc7d5a9bb9d110431f59fa400eebaad162659dc48c0ed9cfd9',
     x86_64: '9d617f18a4cdfb42b45a2b475e36b82dc693244065e021387aa5c222395877ac',
  })

  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "install"
  end

  def self.postinstall
    puts "Try 'man printf' to see if it works.".lightblue
  end
end
