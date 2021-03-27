require 'package'

class Plowshare < Package
  description 'Command-line tool and engine for managing sharing websites'
  homepage 'https://github.com/mcrapet/plowshare'
  version '2.1.7-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/mcrapet/plowshare/archive/v2.1.7.tar.gz'
  source_sha256 'c17d0cc1b3323f72b2c1a5b183a9fcef04e8bfc53c9679a4e1523642310d22ad'

  depends_on 'recode'

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # plowshare bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/plowdown
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/plowshare", @env)
  end
end
