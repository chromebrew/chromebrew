require 'package'

class Crew_launcher < Package
  description 'Add Chromebrew app to launcher'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/supechicken/crew-launcher.git'
  git_hashtag '1.1'
  
  depends_on 'graphicsmagick'

  def self.install
    FileUtils.mkdir_p [
      "#{CREW_DEST_PREFIX}/bin/",
      "#{CREW_DEST_PREFIX}/share/crew-launcher/icon/",
      "#{CREW_DEST_PREFIX}/share/crew-launcher/json/",
      "#{CREW_DEST_DIR}/tmp/crew-launcher/",
      "#{CREW_DEST_PREFIX}/etc/env.d/"
    ]

    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/crew-launcher/"
    FileUtils.ln_s "#{CREW_LIB_PATH}/lib/color.rb", "#{CREW_DEST_PREFIX}/share/crew-launcher/lib"
    FileUtils.ln_s '../share/crew-launcher/main.rb', "#{CREW_DEST_PREFIX}/bin/crew-launcher"
    
    system "curl -L https://github.com/skycocker/chromebrew/raw/gh-pages/images/brew-title.png -o #{CREW_DEST_PREFIX}/share/crew-launcher/icon/brew.png"

    File.write "#{CREW_DEST_PREFIX}/etc/env.d/crew_launcher", <<~EOF
      crew-launcher start-server
    EOF
  end

  def self.remove
    FileUtils.rm_rf "#{CREW_PREFIX}/share/crew-launcher/"
  end
end
