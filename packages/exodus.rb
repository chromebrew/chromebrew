require 'package'

class Exodus < Package
  description 'Exodus is a desktop crypto wallet'
  homepage 'https://www.exodus.com/'
  version '23.6.19'
  license 'Freeware'
  compatibility 'x86_64'
  source_url 'https://downloads.exodus.com/releases/exodus-linux-x64-23.6.19.zip'
  source_sha256 'b9cc4db81dd8efbfe321394b817d641ef854d1b81a8209b330ff07aab6e8b0e0'

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
