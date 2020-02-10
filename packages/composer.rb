require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.9.3'
  source_url 'https://github.com/composer/composer/archive/1.9.3.tar.gz'
  source_sha256 '6d2f36c556bb18294f70b7c2e102dabc5009949bab2b74a137886115693065e5'

  depends_on 'php' unless File.exists? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  def self.preinstall
    if Dir.exists?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      # Save any existing configuration
      system "cp -r #{HOME}/.config #{CREW_PREFIX}" unless Dir.empty? "#{HOME}/.config"
    else
      # Remove the symlink, if it exists
      system "rm -f #{HOME}/.config"
    end
  end

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976'
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=#{version}"
    system "mkdir -p #{CREW_DEST_PREFIX}/.config"
    system "cp -r #{HOME}/.config/composer #{CREW_DEST_PREFIX}/.config"
    system "rm -rf #{HOME}/.config"
    system "ln -s #{CREW_PREFIX}/.config #{HOME}/.config"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
  end
end
