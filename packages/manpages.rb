require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.15'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version.split('-').first}.tar.xz"
  source_sha256 '03d8ebf618bd5df57cb4bf355efa3f4cd3a00b771efd623d4fd042b5dceb4465'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '150e6fc630a8fae3cffe05a42f0b72dcca63f6d8df6d11144bbab98c94b0179f',
     armv7l: '150e6fc630a8fae3cffe05a42f0b72dcca63f6d8df6d11144bbab98c94b0179f',
       i686: '3c6c32922945b4b0cbc6d24aaf46cc12913234e18fb468d67230c1b429cc5b1e',
     x86_64: '4cc7659842be5973daa65f994897f70ee6e55386d3dfd01eacf45329885548d5'
  })

  depends_on 'man_db'

  def self.install
    system 'make', '-R', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
    # Remove conflicts with libxcrypt.
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man3/crypt.3"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man3/crypt_r.3"
  end

  def self.postinstall
    ExitMessage.add "\nTry 'man printf' to see if it works.\n"
  end
end
