require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.13'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version}.tar.xz"
  source_sha256 'b6cb5d67e0bb00a3b3f3d1bcb3fe06c26b045ba63923ed7ae79412350c5e1cb5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab507d4222310755807315216ac0f4f1475449baabed31623e37e4c5a63acba0',
     armv7l: 'ab507d4222310755807315216ac0f4f1475449baabed31623e37e4c5a63acba0',
       i686: 'cc225dc35145d2d2237c18e858c70093cc72375fafdb13f0f3a4de2c4e2e780f',
     x86_64: '4293bcb8dac049c5f1d0b78731037f56365bae160ddc4ddaaabcc98b1d587244'
  })

  depends_on 'man_db'

  def self.install
    system 'make', '-R', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    ExitMessage.add "\nTry 'man printf' to see if it works.\n"
  end
end
