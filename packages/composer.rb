require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.0.7-1'
  compatibility 'all'
  source_url 'https://github.com/composer/composer/archive/2.0.7.tar.gz'
  source_sha256 '204215dccc01fea015de5c8506100a078c821fe31afb3eee5aa93c5841f83f4d'

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
    system "curl -Ls -o composer https://github.com/composer/composer/releases/download/#{version}/composer.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('composer') ) == '0a060e8caf1d5cde55c4562fd68369b08cf231b8fd30da9c8f994b111557ebe9'
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
