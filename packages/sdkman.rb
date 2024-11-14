require 'package'

class Sdkman < Package
  description 'Software Development Kit Manager – your reliable companion for effortlessly managing multiple Software Development Kits.'
  homepage 'https://sdkman.io/'
  version '5.18.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed
  print_source_bashrc

  def self.install
    ENV['SDKMAN_DIR'] = "#{CREW_DEST_PREFIX}/share/sdkman"
    system "curl -s https://get.sdkman.io | sed '419,425d' | bash"
    system "sed -i 's,SDKMAN_DIR=\"\$HOME/\.sdkman\",SDKMAN_DIR=#{CREW_PREFIX}/share/sdkman,' #{CREW_DEST_PREFIX}/share/sdkman/bin/sdkman-init.sh"
    FileUtils.install "#{CREW_DEST_PREFIX}/share/sdkman/contrib/completion/bash/sdk", "#{CREW_DEST_PREFIX}/etc/bash.d/sdkman-completion"
    FileUtils.install "#{CREW_DEST_PREFIX}/share/sdkman/bin/sdkman-init.sh", "#{CREW_DEST_PREFIX}/etc/env.d/sdkman-init"
  end

  def self.postinstall
    ExitMessage.add "\nType 'sdk' to get started.\n".lightblue
  end
end
