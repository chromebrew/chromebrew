require 'package'

class Autossh < Package
  description 'Automatically restart SSH sessions and tunnels'
  homepage 'https://www.harding.motd.ca/autossh/'
  version '1.4g'
  compatibility 'all'
  source_url 'https://www.harding.motd.ca/autossh/autossh-1.4g.tgz'
  source_sha256 '5fc3cee3361ca1615af862364c480593171d0c54ec156de79fc421e31ae21277'

  depends_on 'openssh'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-ssh=$(which ssh)"
    system "make"
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
