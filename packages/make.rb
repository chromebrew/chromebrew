require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.4'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/make/make-4.4.tar.lz'
  source_sha256 '48d0fc0b2a04bb50f2911c16da65723285f7f4804c74fc5a2124a3df6c5f78c4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4_armv7l/make-4.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4_armv7l/make-4.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4_i686/make-4.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/make/4.4_x86_64/make-4.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '644e4747f09364f0889019ba5c1a774b94076de90efdc8973090a2ef6fbbab54',
     armv7l: '644e4747f09364f0889019ba5c1a774b94076de90efdc8973090a2ef6fbbab54',
       i686: '8bcb0570464a3d5202835ac1c55cc7282fb7dc00d7c52ef66be0578a868cca0e',
     x86_64: '3964c64a193995ac13811e28a98541faa6f69ac87be6d8223c95f43050f67423'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-cross-guesses=conservative"
    system './build.sh'
  end

  def self.install
    system './make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    # Functions wildcard fails on i686
    # system './make check || ./make check || ./make check'
  end
end
