require 'package'

class Phpbrew < Package
  description 'Brew & manage PHP versions in pure PHP at HOME'
  homepage 'https://phpbrew.github.io/phpbrew/'
  version '2.2.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/phpbrew/phpbrew/releases/download/2.2.0/phpbrew.phar'
  source_sha256 '3247b8438888827d068542b2891392e3beffebe122f4955251fa4f9efa0da03d'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-phpbrew", <<~EOF
      PHPBREW_SET_PROMPT=1
      PHPBREW_RC_ENABLE=1
    EOF
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/10-phpbrew", <<~EOF
      [[ ! -s #{HOME}/.phpbrew/bashrc ]] && phpbrew init
      [[ -e #{HOME}/.phpbrew/bashrc ]] && source #{HOME}/.phpbrew/bashrc
    EOF
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.phpbrew"
    FileUtils.touch "#{CREW_DEST_HOME}/.phpbrew/bashrc"
    FileUtils.install 'phpbrew.phar', "#{CREW_DEST_PREFIX}/bin/phpbrew", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nSee https://github.com/phpbrew/phpbrew/wiki/Quick-Start for more information.\n".lightblue
  end
end
