require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.7.3'
  source_url 'https://github.com/composer/composer/archive/1.7.3.tar.gz'
  source_sha256 'bad4df3e17eca61d12a4cca0ace934659382ef38a6234be384e79d39e5945c0d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  def self.preinstall
    if Dir.exists? "$HOME/.config"
      # Save any existing configuration
      system "cp -r $HOME/.config #{CREW_PREFIX}"
    else
      # Remove the symlink, if it exists
      system "rm -f $HOME/.config"
    end
  end

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.7.3"
    system "mkdir -p #{CREW_DEST_PREFIX}/.config"
    system "cp -r $HOME/.config/composer #{CREW_DEST_PREFIX}/.config"
    system "rm -rf $HOME/.config"
    system "ln -s #{CREW_PREFIX}/.config $HOME/.config"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
  end
end
