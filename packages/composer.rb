require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.0.4'
  compatibility 'all'
  source_url 'https://github.com/composer/composer/archive/2.0.4.tar.gz'
  source_sha256 '0d699731fe6b3b31a3a2a86032459f08449dbe095fe57749536da922d32294c2'

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
    system "curl -Ls -o composer https://github.com/composer/composer/releases/download/#{version}/composer.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('composer') ) == 'c3b2bc477429c923c69f7f9b137e06b2a93c6a1e192d40ffad1741ee5d54760d'
    system "install -Dm755 composer #{CREW_DEST_PREFIX}/bin/composer"
    FileUtils.ln_sf "#{CREW_PREFIX}/.config", "#{HOME}/.config"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
  end
end
