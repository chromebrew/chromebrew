require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.8.0'
  source_url 'https://github.com/composer/composer/archive/1.8.0.tar.gz'
  source_sha256 'e51374c9946ee85896f8c570feef29fdfc8da08cd24f2e1fdec34b2713fe3a89'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  def self.preinstall
    if Dir.exists? "#{HOME}/.config"
      # Save any existing configuration
      system "cp -r #{HOME}/.config #{CREW_PREFIX}" unless Dir.empty? "#{HOME}/.config"
    else
      # Remove the symlink, if it exists
      system "rm -f #{HOME}/.config"
    end
  end

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8'
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
