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
    aarch64: '26aaae577b8e9bb22e78a4380602e755d13687aa49207d01528be04b8f48eeda',
     armv7l: '26aaae577b8e9bb22e78a4380602e755d13687aa49207d01528be04b8f48eeda',
       i686: 'cc225dc35145d2d2237c18e858c70093cc72375fafdb13f0f3a4de2c4e2e780f',
     x86_64: '74c7efe84473515b74664adfe4507eb4ae382629964bba6b598c6273d006a8ee'
  })

  depends_on 'man_db'

  def self.install
    system 'make', '-R', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    ExitMessage.add "\nTry 'man printf' to see if it works.\n"
  end
end
