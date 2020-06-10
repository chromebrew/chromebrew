require 'package'

class Powerline_fonts < Package
  description 'Patched fonts for Powerline users.'
  homepage 'https://github.com/powerline/fonts'
  version '2015-12-04'
  compatibility 'all'
  source_url 'https://github.com/powerline/fonts/archive/2015-12-04.tar.gz'
  source_sha256 '3a0b73abca6334b5e6bddefab67f6eb1b2fac1231817d95fc79126c8998c4844'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerline_fonts-2015-12-04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerline_fonts-2015-12-04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerline_fonts-2015-12-04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerline_fonts-2015-12-04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f8a9f001b5e1fb43795a6f3c1ac430ae1a1cae8f192f43b416d694518fea8050',
     armv7l: 'f8a9f001b5e1fb43795a6f3c1ac430ae1a1cae8f192f43b416d694518fea8050',
       i686: '3c0ef20d744105d0e5c7a43f644c83986bfb1f5a90342115afe7730328482b68',
     x86_64: 'ef0fbbbbafa3c82924d3547654d7456e64787b2847f996f6d946e0f05b3943b5',
  })

  def self.install
    fonts = "#{CREW_DEST_PREFIX}/share/fonts"
    FileUtils.mkdir_p(fonts)

    Dir.glob('*').each do |f|
      FileUtils.mv(f, fonts) unless ["README.rst", "install.sh"].include? f
    end

    FileUtils.mkdir_p("#{CREW_DEST_HOME}")
    FileUtils.cd("#{CREW_DEST_HOME}") do
      File.open('.font.conf','w') do |f|
        f.puts "<?xml version=\"1.0\"?>"
        f.puts "<!DOCTYPE fontconfig SYSTEM \"fonts.dtd\">"
        f.puts "<fontconfig>"
        f.puts "\t<dir>#{CREW_PREFIX}/share/fonts</dir>"
        f.puts "</fontconfig>"
      end

      puts "\nFonts will be available after restart or chrome:inducebrowsercrashforrealz"
      puts "To change the font in crosh, enable developer tools in extensions and execute:"
      puts "\tterm_.prefs_.set(\"font-family\", \"DejaVu Sans Mono for Powerline\")"
      puts "in the Javascript Console to change the font to DejaVu Sans Mono, for example\n\n"
    end
  end
end
