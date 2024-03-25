require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.7.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/composer/composer/releases/download/2.7.2/composer.phar'
  source_sha256 '049b8e0ed9f264d770a0510858cffbc35401510759edc9a784b3a5c6e020bcac'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"
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
  end
end
