require 'package'

class Powerline_fonts < Package
  version '1'
  binary_url ({
    i686: "https://www.dropbox.com/s/lkrnw3hu7yb88vt/powerline_fonts.tar.gz?dl=0",
    x86_64: "https://www.dropbox.com/s/lkrnw3hu7yb88vt/powerline_fonts.tar.gz?dl=0"
  })
  binary_sha1 ({
    i686: "c5bcd35c94feed9cb48bb821c2d08f3ddc36dc64",
    x86_64: "c5bcd35c94feed9cb48bb821c2d08f3ddc36dc64"
  })
  
  puts "\nFonts will be available after restart or chrome:inducebrowsercrashforrealz"
  puts "To change the font in crosh, enable developer tools in extensions and execute:"
  puts "\tterm_.prefs_.set(\"font-family\", \"DejaVu Sans Mono for Powerline\")" 
  puts "in the Javascript Console to change the font to DejaVu Sans Mono, for example\n\n"
  
end
