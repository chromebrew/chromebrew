require 'package'

class Crew_sudo < Package
  description 'Workaround for using sudo on ChromeOS crosh shell (ChromeOS v117+)'
  homepage 'https://github.com/chromebrew/crew-sudo'
  version '1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-sudo.git'
  git_hashtag "v#{@version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a5b7f96712d98010636cc8801d1251ad4b2bb66abd3606f86b2caf6c687baf9',
     armv7l: '6a5b7f96712d98010636cc8801d1251ad4b2bb66abd3606f86b2caf6c687baf9',
     x86_64: '6b7a5b5482541fd79b9ae7ae88d6296f914a3884a5f57fb55704d56194086718'
  })

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
