require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.13'
  source_url 'https://www.kernel.org/pub/linux/docs/man-pages/man-pages-4.13.tar.xz'
  source_sha256 'd5c005c5b653248ab6680560de00ea8572ff39e48a57bd5be1468d986a0631bf'

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
