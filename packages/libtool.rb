require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.4.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libtool/libtool-2.4.7.tar.xz'
  source_sha256 '4f7f217f057ce655ff22559ad221a0fd8ef84ad1fc5fcb6990cecc333aa1635d'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtool/2.4.7_i686/libtool-2.4.7-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtool/2.4.7_x86_64/libtool-2.4.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '1b07197ea6683afa881e858adddb9909a52759af6a80a1bfe14a1cd185c58424',
  x86_64: '2d23028648189ae30acb1a18b758aeb9ca3146b29bef4cf1758ab4cfc678c490'
  })

  depends_on 'm4'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-ltdl-install"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
