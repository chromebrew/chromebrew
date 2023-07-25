require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.5.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/composer/composer/releases/download/2.5.8/composer.phar'
  source_sha256 'f07934fad44f9048c0dc875a506cca31cc2794d6aebfc1867f3b1fbf48dce2c5'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  no_compile_needed

  def self.preinstall
    if Dir.exist?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      # Save any existing configuration
      FileUtils.cp_r "#{HOME}/.config", CREW_PREFIX.to_s, remove_destination: true unless Dir.empty? "#{HOME}/.config"
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
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end
end
