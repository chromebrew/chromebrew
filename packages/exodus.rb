require 'package'

class Exodus < Package
  description 'Exodus is a desktop crypto wallet'
  homepage 'https://www.exodus.com/'
  version '21.6.18'
  license 'Freeware'
  compatibility 'x86_64'
  source_url 'https://downloads.exodus.com/releases/exodus-linux-x64-21.6.18.zip'
  source_sha256 '94f81db2bcd0eab66bec71a7ac8926173413894359de4ccf9324514894440679'

  binary_url ({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exodus/21.6.18_x86_64/exodus-21.6.18-chromeos-x86_64.tpxz'
  })
  binary_sha256 ({
    x86_64: '3e238cbb72121e8e67a8c276397ad9386056b250b3aad6d12bc6a788a05b84a7'
  })

  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Exodus-linux-x64"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/Exodus-linux-x64"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Exodus-linux-x64/Exodus", "#{CREW_DEST_PREFIX}/bin/exodus"
  end

  def self.postinstall
    puts "\nType 'exodus' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/Exodus"
    if Dir.exists? config_dir
      puts "WARNING: This will remove all Exodus data!".orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case STDIN.getc
      when "y", "Y"
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
