require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.04'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-6.04.tar.xz'
  source_sha256 'c2c0b9329955df81af45ee80ebc84c47291f95df5157db1fab988199f9371af1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/manpages/6.04_armv7l/manpages-6.04-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/manpages/6.04_armv7l/manpages-6.04-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/manpages/6.04_i686/manpages-6.04-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/manpages/6.04_x86_64/manpages-6.04-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f6029a96085062250e4a05f1264d4b9903f8b223d5cb70e11f6f91b5e60e1f0',
     armv7l: '4f6029a96085062250e4a05f1264d4b9903f8b223d5cb70e11f6f91b5e60e1f0',
       i686: 'be52c3acdf80f293a248a7c1a32dd8114c7aa877b68aec1b0172933b2e18997a',
     x86_64: 'f81883ab722914a7747fa19adeb70a9a1e6fa8dc12f19e8aca34c08072a6d103'
  })

  depends_on 'mandb'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    puts "\nTry 'man printf' to see if it works.\n".lightblue
  end
end
