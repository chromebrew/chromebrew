require 'package'

class Crew_sudo < Package
  description 'Workaround for using sudo on ChromeOS crosh shell (ChromeOS v117+)'
  homepage 'https://github.com/supechicken/crew-sudo'
  version '1.0'
  license 'GPL-3'
  compatibility 'all'

  source_url 'https://github.com/supechicken/crew-sudo.git'
  #git_hashtag '1.0'
  git_branch 'main'

  no_compile_needed

  def self.install
    system({ 'CREW_DEST_PREFIX' => CREW_DEST_PREFIX }, './install.sh')
  end

  def self.postinstall
    ExitMessage.add <<~EOT

      In order to make sudo work properly, the crew-sudo daemon needs to
      start in the VT-2 shell every boot by:

        - Press Ctrl + Alt + -> to enter VT-2 shell
        - Log in as 'chronos' user
        - The daemon should start automatically now
        - Press Ctrl + Alt + <- to switch back to ChromeOS UI

      EOT
  end
end
