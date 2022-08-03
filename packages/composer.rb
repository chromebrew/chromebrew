require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.3.10'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  no_compile_needed

  def self.preinstall
    if Dir.exist?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      # Save any existing configuration
      FileUtils.cp_r "#{HOME}/.config", "#{CREW_PREFIX}", remove_destination: true unless Dir.empty? "#{HOME}/.config"
    else
      # Remove the symlink, if it exists
      FileUtils.rm_f "#{HOME}/.config"
    end
  end

  def self.install
    downloader "https://github.com/composer/composer/releases/download/#{version}/composer.phar",
               'd808272f284fa8e0f8b470703e1438ac8f362030bbc9d12e29530277d767aff0', 'composer'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'composer', "#{CREW_DEST_PREFIX}/bin/composer", mode: 0o755
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/.config", "#{HOME}/.config"
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc\n".lightblue
  end
end
