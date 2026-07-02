require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.10.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/composer/composer/releases/download/#{version}/composer.phar"
  source_sha256 '5ee7125f8a30a34d246cefdc0bc85b8a783b28f2aec968994118512350d28027'

  depends_on 'php84' unless File.exist? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  no_compile_needed
  print_source_bashrc

  def self.preinstall
    if Dir.exist?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      # Save any existing configuration
      FileUtils.cp_r "#{HOME}/.config", CREW_PREFIX, remove_destination: true unless Dir.empty? "#{HOME}/.config"
    else
      # Remove the symlink, if it exists
      FileUtils.rm_f "#{HOME}/.config"
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.install 'composer.phar', "#{CREW_DEST_PREFIX}/bin/composer", mode: 0o755
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-composer", <<~EOF
      PATH=$HOME/.config/composer/vendor/bin:$PATH
    EOF
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/.config", "#{HOME}/.config"
    ExitMessage.add <<~EOF

      To finish the installation, execute the following:
      composer self-update --update-keys
    EOF
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/composer")
  end
end
