require 'package'

class Hub < Package
  description 'hub is a command-line wrapper for git that makes you better at GitHub.'
  homepage 'https://hub.github.com/'
  version '2.3.0-pre9'
  source_url 'https://github.com/github/hub/archive/v2.3.0-pre9.tar.gz'
  source_sha1 'd18f0a28d13b7e773186ece35df032f561d2172d'

  depends_on 'git'
  depends_on 'go'

  def self.install
    system "script/build -o /usr/local/bin/hub"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp /usr/local/bin/hub #{CREW_DEST_DIR}/usr/local/bin"
    puts ""
    puts "You will need to add an alias in order to use hub as a git wrapper:".lightblue
    puts "echo \"alias git=hub\" >> ~/.bashrc && source ~/.bashrc".lightblue
    puts ""
  end
end
