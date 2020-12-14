require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.0.8'
  compatibility 'all'
  source_url 'https://github.com/composer/composer/archive/2.0.8.tar.gz'
  source_sha256 '009f1d8ee3d5050a78b3732a947d4a10c2718dfbb83da52c3fcf71ff2d7dd465'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"
  depends_on 'xdg_base'

  def self.preinstall
    if Dir.exists?("#{HOME}/.config") && !File.symlink?("#{HOME}/.config")
      # Save any existing configuration
      FileUtils.cp_r "#{HOME}/.config", "#{CREW_PREFIX}", remove_destination: true unless Dir.empty? "#{HOME}/.config"
    else
      # Remove the symlink, if it exists
      FileUtils.rm_f "#{HOME}/.config"
    end
  end

  def self.install
    system 'curl -Ls -o composer https://github.com/composer/composer/releases/download/2.0.8/composer.phar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('composer') ) == '2021f0d52b446e0efe3c548cc058ab5671fa38cdbcf814e7911c7e9d71d61538'
    system "install -Dm755 composer #{CREW_DEST_PREFIX}/bin/composer"
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/.config", "#{HOME}/.config"
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc".lightblue
    puts
  end
end
