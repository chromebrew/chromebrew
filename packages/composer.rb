require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.7.0'
  source_url 'https://github.com/composer/composer/archive/1.7.0.tar.gz'
  source_sha256 '08fd8538872f59c666d4c0a5596e8aff65ddb76900f615e1480d1e8803563adc'

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
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.7.0"
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
