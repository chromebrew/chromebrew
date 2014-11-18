require 'package'

class Powerline_fonts < Package
  version '1'
  source_url 'https://github.com/Lokaltog/powerline-fonts/tarball/master'
  source_sha1 '126437bd40b41bfef1e6e0b9b81c1cf0ff2bbb4f'
  
  def self.install
    fonts = "#{CREW_DEST_DIR}/usr/local/share/fonts"
    FileUtils.mkdir_p(fonts)
    
    Dir.glob('*').each do |f| 
      FileUtils.mv(f, fonts) unless ["README.rst", "install.sh"].include? f
    end
    
    home = "#{CREW_DEST_DIR}/home/chronos/user"
    FileUtils.mkdir_p(home)
    FileUtils.cd(home) do
      File.open('.font.conf','w') do |f|
        f.puts "<?xml version=\"1.0\"?>"
	    f.puts "<!DOCTYPE fontconfig SYSTEM \"fonts.dtd\">"
        f.puts "<fontconfig>"
	    f.puts "\t<dir>/usr/local/share/fonts</dir>"
        f.puts "</fontconfig>"
      end
    end
    
    puts "\nFonts will be available after restart or chrome:inducebrowsercrashforrealz"
    puts "To change the font in crosh, enable developer tools in extensions and execute:"
    puts "\tterm_.prefs_.set(\"font-family\", \"DejaVu Sans Mono for Powerline\")" 
    puts "in the Javascript Console to change the font to DejaVu Sans Mono, for example\n\n"
  
  end
end
