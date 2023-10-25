require 'package'

class Crew_sudo < Package
  description 'Workaround for using sudo on ChromeOS crosh shell (ChromeOS v117+)'
  homepage 'https://github.com/supechicken/crew-sudo'
  version '1.0'
  license 'GPL-3'
  compatibility 'all'

  source_url 'https://github.com/supechicken/crew-sudo.git'
  git_hashtag 'v1.0'

  def self.install
    bindir = File.join(CREW_DEST_PREFIX, 'bin')
    envdir = File.join(CREW_DEST_PREFIX, 'etc/env.d')
    path   = File.join(CREW_PREFIX, 'lib/crew-sudo')

    FileUtils.mkdir_p bindir, File.join(CREW_DEST_DIR, path)
    FileUtils.cp_r Dir['*'], File.join(CREW_DEST_DIR, path)

    FileUtils.ln_s "#{path}/crew-sudo", "#{bindir}/crew-sudo"
    FileUtils.ln_s "#{path}/crew-sudo", "#{bindir}/sudo"
    FileUtils.ln_s "#{path}/crew-sudo", "#{bindir}/sudod"

    FileUtils.cp 'autostart/crew-sudo.sh', envdir
  end

  def self.postinstall
    warn <<~EOT.lightblue

      In order to make sudo works properly, the crew-sudo daemon need to
      start in the VT-2 shell every boot by:

        - Press Ctrl + Alt + -> to enter VT-2 shell
        - Log in as 'chronos' user
        - The daemon should start automatically now
        - Press Ctrl + Alt + <- to switch back to ChromeOS UI

      EOT
  end
end