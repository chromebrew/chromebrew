require 'package'

class Exodus < Package
  description 'Exodus is a desktop crypto wallet'
  homepage 'https://www.exodus.com/'
  version '24.29.2'
  license 'Freeware'
  compatibility 'x86_64'
  source_url "https://downloads.exodus.com/releases/exodus-linux-x64-#{version}.zip"
  source_sha256 '9c2147a9555da6f4ca9d0f47dd5d7efb4152c03bf35411bf6c69550731adc9a8'

  depends_on 'at_spi2_core'
  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Exodus-linux-x64"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/Exodus-linux-x64"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Exodus-linux-x64/Exodus", "#{CREW_DEST_PREFIX}/bin/exodus"
  end

  def self.postinstall
    ExitMessage.add "\nType 'exodus' to get started.\n"
  end

  def self.postremove
    config_dir = "#{CREW_PREFIX}/.config/Exodus"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all Exodus data!'.orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
