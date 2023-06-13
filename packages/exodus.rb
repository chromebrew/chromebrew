require 'package'

class Exodus < Package
  description 'Exodus is a desktop crypto wallet'
  homepage 'https://www.exodus.com/'
  version '22.3.31'
  license 'Freeware'
  compatibility 'x86_64'
  source_url 'https://downloads.exodus.com/releases/exodus-linux-x64-22.3.31.zip'
  source_sha256 '2c94fa2f9cec42b23f3a1bc2778cd112cbe4040aea1c3ffe6f6b1f2a3899abf5'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exodus/22.3.31_x86_64/exodus-22.3.31-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '61d9fca621e8747d13c46329a9fd05c5ad636860fa99999a302cd15e9fe1a57f'
  })

  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Exodus-linux-x64"
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/Exodus-linux-x64"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Exodus-linux-x64/Exodus", "#{CREW_DEST_PREFIX}/bin/exodus"
  end

  def self.postinstall
    puts "\nType 'exodus' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/Exodus"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all Exodus data!'.orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightblue
      end
    end
  end
end
