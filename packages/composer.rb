require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '2.2.5'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

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
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('composer') ) == '81ef304a70c957d6f05a7659f03b00eb50df6155195f51118459b2e49c96c3f3'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'composer', "#{CREW_DEST_PREFIX}/bin/composer", mode: 0o755
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/.config", "#{HOME}/.config"
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.config/composer/vendor/bin:\$PATH' >> ~/.bashrc && . ~/.bashrc\n".lightblue
  end
end
