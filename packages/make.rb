require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.4.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/make/make-4.4.1.tar.lz'
  source_sha256 '8814ba072182b605d156d7589c19a43b89fc58ea479b9355146160946f8cf6e9'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4.1_armv7l/make-4.4.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4.1_armv7l/make-4.4.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4.1_i686/make-4.4.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4.1_x86_64/make-4.4.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'eff1ea4983d10785fce3c1660f2ca564e3931fbe061b82632cce58a35b13efeb',
     armv7l: 'eff1ea4983d10785fce3c1660f2ca564e3931fbe061b82632cce58a35b13efeb',
       i686: '71eeab28cc8e7d89b71cc6e1a71548638c8c8155348320679a1164e7731d88da',
     x86_64: '2ba3b3be1433ecdce1e52fb023a91a64b11d429ca5e119264c20972e9d1befd7'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-cross-guesses=conservative"
    system './build.sh'
  end

  def self.check
    system './make check'
  end

  def self.install
    system './make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
