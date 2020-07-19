require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.10.9'
  compatibility 'all'
  source_url 'https://github.com/composer/composer/archive/1.10.9.tar.gz'
  source_sha256 '85f8a8562290d43e56cbf9aa1af49b3ec3120866b51e801904dfafdd7e5414ba'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  def self.preinstall
    if Dir.exists?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      # Save any existing configuration
      FileUtils.cp_r "#{HOME}/.config", "#{CREW_PREFIX}" unless Dir.empty? "#{HOME}/.config"
    else
      # Remove the symlink, if it exists
      FileUtils.rm_f "#{HOME}/.config"
    end
  end

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    system 'curl -Ls -o installer.sig https://composer.github.io/installer.sig'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == File.read('installer.sig')
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=#{version}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config"
    FileUtils.cp_r "#{HOME}/.config/composer", "#{CREW_DEST_PREFIX}/.config"
    FileUtils.rm_rf "#{HOME}/.config"
    FileUtils.ln_s "#{CREW_PREFIX}/.config", "#{HOME}/.config"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
  end
end
