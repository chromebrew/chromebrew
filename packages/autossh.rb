require 'package'

class Autossh < Package
  description 'Automatically restart SSH sessions and tunnels'
  homepage 'https://www.harding.motd.ca/autossh/'
  version '1.4g'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.harding.motd.ca/autossh/autossh-1.4g.tgz'
  source_sha256 '5fc3cee3361ca1615af862364c480593171d0c54ec156de79fc421e31ae21277'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '6cb94ea21f975411bd5dd4b00bf237f0018f2c6cad16a0cb0676a61a026626e3',
     armv7l: '6cb94ea21f975411bd5dd4b00bf237f0018f2c6cad16a0cb0676a61a026626e3',
       i686: '964229e816b5b085b87b4e0823e7dd625704cd5f2a977c1cdf7ad2c40039cf50',
     x86_64: '776bf56c0dc88d5628026a20c25f346fc63f07334bbd16995feb628f055624fc'
  })

  depends_on 'openssh'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-ssh=$(which ssh)"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/doc/autossh"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/examples/autossh"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp autossh #{CREW_DEST_PREFIX}/bin"
    system "cp CHANGES README #{CREW_DEST_PREFIX}/share/doc/autossh"
    system "cp autossh.host rscreen #{CREW_DEST_PREFIX}/share/examples/autossh"
    system "cp autossh.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end
