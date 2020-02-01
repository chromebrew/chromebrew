require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.10.1'
  source_url 'https://github.com/composer/composer/archive/1.10.1.tar.gz'
  source_sha256 '9d19d87a63a4927c20ed8e21dc2dd472eaf86deaf529917591557945464d5573'

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
    system 'curl -Ls -o installer.sig https://composer.github.io/installer.sig'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == File.read('installer.sig')
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
