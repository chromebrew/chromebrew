require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.9'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version}.tar.xz"
  source_sha256 'd14caff54cc662f34b1b70bcf62d4e27e4c2fd260672a35b6e74af71b3f71f88'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b468aad94416658289624a9d5c013f781b69aac7e15c64d3562f738b0684b40',
     armv7l: '1b468aad94416658289624a9d5c013f781b69aac7e15c64d3562f738b0684b40',
       i686: '5d5e1e9530401745e471050b4d2a33040d986ddbae21ba6c6906f106593918b7',
     x86_64: '51cbc74fd2139adcff1be2d0bc39e2a050c17378797674894831435329bf301d'
  })

  depends_on 'man_db'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    ExitMessage.add "\nTry 'man printf' to see if it works.\n".lightblue
  end
end
