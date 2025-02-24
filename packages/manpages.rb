require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.12'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version}.tar.xz"
  source_sha256 'b6cb5d67e0bb00a3b3f3d1bcb3fe06c26b045ba63923ed7ae79412350c5e1cb5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15d1ba25c9bdd2b00b00e8fe0a318f4cf34af6282a75c9c9edc4121c891a2596',
     armv7l: '15d1ba25c9bdd2b00b00e8fe0a318f4cf34af6282a75c9c9edc4121c891a2596',
       i686: '5936e628f60eaa417dbfa8b23d6b049d7d838eec674607fcbf82409a56d78a22',
     x86_64: '5b5efe0e84c640b041b3edcb2c8442c36290230d153de6a124368810f34c12bf'
  })

  depends_on 'man_db'

  def self.install
    system 'make', '-R', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
  end

  def self.postinstall
    ExitMessage.add "\nTry 'man printf' to see if it works.\n"
  end
end
