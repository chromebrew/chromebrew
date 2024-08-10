# Note that this needs a source_url that isn't git since this is
# downloaded before git is available.
require 'package'

class Crew_sudo < Package
  description 'Workaround for using sudo on ChromeOS crosh shell (ChromeOS v117+)'
  homepage 'https://github.com/chromebrew/crew-sudo'
  version '1.1'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/chromebrew/crew-sudo.git'
  git_hashtag "v#{@version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '978c7fad9ecd7f1e3917843f94b709e2b15b62a4dea0327375eda17a75e38ecc',
     armv7l: '978c7fad9ecd7f1e3917843f94b709e2b15b62a4dea0327375eda17a75e38ecc',
     x86_64: '486cc1227bed448edfeb828f78c3776290a5a553fbcffb6e76d4df87c1ffc4d6'
  })

  def self.install
    system({ 'CREW_DEST_PREFIX' => CREW_DEST_PREFIX }, './install.sh')
    FileUtils.rm_rf File.join(CREW_DEST_PREFIX, 'lib/crew-sudo/.git')
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
