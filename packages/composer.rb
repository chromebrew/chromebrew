require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.7.2'
  source_url 'https://github.com/composer/composer/archive/1.7.2.tar.gz'
  source_sha256 'b0d9fa978b0a05017de60d25701fbe270b4a49870d6c4e573b5678ad565c1743'

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
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.7.2"
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
