require 'package'

class Powerline_fonts < Package
  description 'Patched fonts for Powerline users.'
  homepage 'https://github.com/powerline/fonts'
  version '1.1'
  source_url 'https://codeload.github.com/powerline/fonts/tar.gz/2015-12-04?dummy=/'
  source_sha256 '3a0b73abca6334b5e6bddefab67f6eb1b2fac1231817d95fc79126c8998c4844'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/powerline_fonts-1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/powerline_fonts-1.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/powerline_fonts-1.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/powerline_fonts-1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '12dbb3c203ce8605b729a2782268ee564ac44dc0855820a57388e9cf7878b0b3',
     armv7l: '12dbb3c203ce8605b729a2782268ee564ac44dc0855820a57388e9cf7878b0b3',
       i686: '71722a9389f4e0cfa0efebdd588fc5497108d52fe887958a24a710c9f450bdee',
     x86_64: 'd393b1c392bd70949bbc77aff791a52781aa044d9c8951eca442fc3b66d90246',
  })

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
