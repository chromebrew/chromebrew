require 'package'

class Command_not_found < Package
  description 'Show suggestions for non-installed commands'
  homepage 'https://github.com/chromebrew/crew-command-not-found'
  version '0.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/supechicken/crew-command-not-found.git'
  git_hashtag @version

  def self.build
    system "mold -run cc #{CREW_COMMON_FLAGS} command-not-found-handler.c -o command-not-found-handler"
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_PREFIX}/bin #{CREW_PREFIX}/etc/bash.d]
    FileUtils.install 'command-not-found-handler', "#{CREW_PREFIX}/bin/command-not-found-handler", mode: 0o755
    FileUtils.install 'command-not-found.sh', "#{CREW_PREFIX}/etc/bash.d/03-command-not-found", mode: 0o644
  end
end
