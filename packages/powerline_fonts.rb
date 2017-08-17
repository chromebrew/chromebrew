require 'package'

class Powerline_fonts < Package
  description 'Patched fonts for Powerline users.'
  homepage 'https://github.com/powerline/fonts'
  version '1.1'
  source_url 'https://codeload.github.com/powerline/fonts/tar.gz/2015-12-04?dummy=/'
  source_sha256 '3a0b73abca6334b5e6bddefab67f6eb1b2fac1231817d95fc79126c8998c4844'

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

      puts "\nFonts will be available after restart or chrome:inducebrowsercrashforrealz"
      puts "To change the font in crosh, enable developer tools in extensions and execute:"
      puts "\tterm_.prefs_.set(\"font-family\", \"DejaVu Sans Mono for Powerline\")"
      puts "in the Javascript Console to change the font to DejaVu Sans Mono, for example\n\n"
    end
  end
end
