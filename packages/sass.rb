require 'package'

class Sass < Package
  description 'A Dart implementation of Sass. Sass makes CSS fun again.'
  homepage 'https://sass-lang.com/'
  version '1.32.8'
  compatibility 'all'
  source_url 'https://github.com/sass/dart-sass/archive/1.32.8.tar.gz'
  source_sha256 '1b7679f55bd621af878265ce8b07e3de404779b5f390b6f74ef76c9bacf292b2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.32.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.32.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.32.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sass-1.32.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '12ea3b5e50d909b9375b9e2ae4063f73dd073716d6dc431ee10e0bbdd9eaacfc',
     armv7l: '12ea3b5e50d909b9375b9e2ae4063f73dd073716d6dc431ee10e0bbdd9eaacfc',
       i686: '3713b8427deb027e3559f340aaeb0bd1b049f7c71f45c770f02cfcf11ae9a7e9',
     x86_64: 'cf675aae3203699f6169e42bd342ce8579ca93b920e8675873af7a374006ab6f'
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
