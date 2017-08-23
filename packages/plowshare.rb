require 'package'

class Plowshare < Package
  description 'Command-line tool and engine for managing sharing websites'
  homepage 'https://github.com/mcrapet/plowshare'
  version '2.1.7'
  source_url 'https://github.com/mcrapet/plowshare/archive/v2.1.7.tar.gz'
  source_sha256 'c17d0cc1b3323f72b2c1a5b183a9fcef04e8bfc53c9679a4e1523642310d22ad'

  depends_on 'recode'

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  #end

  # uncomment after PR #1110 is merged
  #def self.postinstall
    puts
    puts "To add command completion for bash, execute the following:".lightblue
    puts "echo '# plowdown completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/bash-completion/completions/plowdown ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/completions/plowdown' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
