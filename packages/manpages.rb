require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.05'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-6.05.tar.xz'
  source_sha256 '89b1445cfe2e3de8bd139758c78f08b37813cff217b9fb1c8df55fd9407875a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '427a66bccf54aabdbf63ed8a72e5a27438465141358ca1411cef09043c6b416b',
     armv7l: '427a66bccf54aabdbf63ed8a72e5a27438465141358ca1411cef09043c6b416b',
       i686: '1d6486354a0b0079bfb8664ad6e87727d277eec1edf7b120e3a958c196353932',
     x86_64: '09f9200441150d3ad79cb99e506cf837aa0bc87711eb4a4d35a09ca89034ae5c'
  })

  depends_on 'mandb'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    puts "\nTry 'man printf' to see if it works.\n".lightblue
  end
end
