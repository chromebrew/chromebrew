require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.8'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-6.8.tar.xz'
  source_sha256 'b9c6b0a420f839148be04b2fc13a85692313728d54d47c69c8a138379665d226'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f486cb05ecea867dffc7a0c5d60edf2b073d552e65a840b3b29e12e32593e38d',
     armv7l: 'f486cb05ecea867dffc7a0c5d60edf2b073d552e65a840b3b29e12e32593e38d',
       i686: 'fc94cfd272bd3c8a60dad9e43d01c54a5746ac80dc29158c4c7d999cba7c249f',
     x86_64: '812d7acf982fd98946aba5132a08685a950d7e6bddfd8ba9e4b45b4ed3b38b29'
  })

  depends_on 'mandb'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    puts "\nTry 'man printf' to see if it works.\n".lightblue
  end
end
