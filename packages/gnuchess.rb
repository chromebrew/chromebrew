require 'package'

class Gnuchess < Package
  description 'GNU Chess is a chess-playing program.'
  homepage 'https://www.gnu.org/software/chess/'
  version '6.2.9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/chess/gnuchess-6.2.9.tar.gz'
  source_sha256 'ddfcc20bdd756900a9ab6c42c7daf90a2893bf7f19ce347420ce36baebc41890'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnuchess/6.2.9_armv7l/gnuchess-6.2.9-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnuchess/6.2.9_armv7l/gnuchess-6.2.9-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnuchess/6.2.9_i686/gnuchess-6.2.9-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnuchess/6.2.9_x86_64/gnuchess-6.2.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '04cbe6c7a1175da4efec1fbf4e2e804a565910a3d9a858bb5d642ecda39c804f',
     armv7l: '04cbe6c7a1175da4efec1fbf4e2e804a565910a3d9a858bb5d642ecda39c804f',
       i686: '8741213f6f4ae25654c7a4df3c5c17566101dffcd8f932eda0048415996b7ef8',
     x86_64: 'fcf26dedf74b36d4b470b89f6accacafb88675b85db8e76862c179560ef7163d'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --with-readline"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
