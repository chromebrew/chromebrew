require 'package'

class Sass < Package
  description 'A Dart implementation of Sass. Sass makes CSS fun again.'
  homepage 'https://sass-lang.com/'
  version '1.26.10'
  compatibility 'all'
  source_url 'https://github.com/sass/dart-sass/archive/1.26.10.tar.gz'
  source_sha256 '9131be72e3eb6d32265e354d6da9f9162d9b28ed5b4910f03744c31509be894f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'dart'

  def self.install
    system 'pub get'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dart-sass"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/dart-sass"
    system "echo '#!/bin/bash' >> sass" 
    system "echo 'dart #{CREW_PREFIX}/share/dart-sass/bin/sass.dart $@' >> sass"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'sass', "#{CREW_DEST_PREFIX}/bin/."
    FileUtils.chmod 0755, "#{CREW_DEST_PREFIX}/bin/sass"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/sass", "#{CREW_PREFIX}/bin/scss"
  end
end
