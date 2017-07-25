require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '4.12'
  source_url 'https://www.kernel.org/pub/linux/docs/man-pages/man-pages-4.12.tar.xz'
  source_sha256 '6f6d79d991fed04e16e7c7a15705304b0b9d51de772c51c57428555039fbe093'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "prefix=/usr/local", "install"
    puts "Try 'man printf' to see if it works. You should have package 'mandb' installed.".lightblue
  end
end
