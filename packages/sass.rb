require 'package'

class Sass < Package
  description 'A Dart implementation of Sass. Sass makes CSS fun again.'
  homepage 'https://sass-lang.com/'
  version '1.26.10'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/sass/dart-sass/archive/1.26.10.tar.gz'
  source_sha256 '9131be72e3eb6d32265e354d6da9f9162d9b28ed5b4910f03744c31509be894f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.26.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.26.10-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.26.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8383f0b0ceb0cd6193bd029bba483bc427fa150ecf2753180a5d75b2f16f4c72',
     armv7l: '8383f0b0ceb0cd6193bd029bba483bc427fa150ecf2753180a5d75b2f16f4c72',
     x86_64: 'c7bfe1b6caf87fd1f78d7ce0cc9e4ec68633d80f150470e751885df2fe0a0781',
  })

  depends_on 'dart'

  def self.build
    system "echo '#!/bin/bash' >> sass" 
    system "echo 'dart #{CREW_PREFIX}/share/dart-sass/bin/sass.dart $@' >> sass"
  end

  def self.install
    system 'pub get'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dart-sass"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/dart-sass"
    system "install -Dm755 sass #{CREW_DEST_PREFIX}/bin/sass"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/sass", "#{CREW_PREFIX}/bin/scss"
  end
end
