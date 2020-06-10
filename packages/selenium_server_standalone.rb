require 'package'

class Selenium_server_standalone < Package
  description 'Selenium is a set of different software tools each with a different approach to supporting test automation.'
  homepage 'https://www.seleniumhq.org/'
  version '3.11.0'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/SeleniumHQ/selenium/selenium-3.11.0/README.md'
  source_sha256 '662789e2508babe0be2d5b3b84630834b7727ed1960b66567be1c73eed08433b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/selenium_server_standalone-3.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/selenium_server_standalone-3.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/selenium_server_standalone-3.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/selenium_server_standalone-3.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '38dd130c44c9cd16deefd85201331343ef675229870ddd80f1d9a2fbc7cfd432',
     armv7l: '38dd130c44c9cd16deefd85201331343ef675229870ddd80f1d9a2fbc7cfd432',
       i686: '9c28cecde0b64d1570e2298605e646de730171ae6777966b90fe7fc96cec9e7f',
     x86_64: '03c5ef09c37265bd9793bda2a1b4bf62e6b2b98c67921b81276313d78ab5396d',
  })

  depends_on 'jdk8'

  def self.build
    system "echo '#!/bin/bash' > startselenium"
    system "echo 'SELENIUM=\$(ps ax | grep \"selenium-server-standalone\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startselenium"
    system "echo 'if [ -z \"\$SELENIUM\" ]; then' >> startselenium"
    system "echo '  java -jar #{CREW_PREFIX}/share/selenium-server/selenium-server-standalone-3.11.0.jar &' >> startselenium"
    system "echo 'fi' >> startselenium"
    system "echo 'sleep 5' >> startselenium"
    system "echo 'SELENIUM=\$(ps ax | grep \"selenium-server-standalone\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startselenium"
    system "echo 'if [ ! -z \"\$SELENIUM\" ]; then' >> startselenium"
    system "echo '  echo \"selenium-server-standalone process \$SELENIUM is running\"' >> startselenium"
    system "echo 'else' >> startselenium"
    system "echo '  echo \"selenium failed to start\"' >> startselenium"
    system "echo '  exit 1' >> startselenium"
    system "echo 'fi' >> startselenium"
    system "echo '#!/bin/bash' > stopselenium"
    system "echo 'SELENIUM=\$(ps ax | grep \"selenium-server-standalone\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopselenium"
    system "echo 'if [ ! -z \"\$SELENIUM\" ]; then' >> stopselenium"
    system "echo '  kill \$SELENIUM' >> stopselenium"
    system "echo 'fi' >> stopselenium"
    system "echo 'sleep 5' >> stopselenium"
    system "echo 'SELENIUM=\$(ps ax | grep \"selenium-server-standalone\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopselenium"
    system "echo 'if [ -z \"\$SELENIUM\" ]; then' >> stopselenium"
    system "echo '  echo \"selenium-server-standalone process stopped\"' >> stopselenium"
    system "echo 'else' >> stopselenium"
    system "echo '  echo \"selenium-server-standalone process \$SELENIUM is running\"' >> stopselenium"
    system "echo '  exit 1' >> stopselenium"
    system "echo 'fi' >> stopselenium"
  end

  def self.install
    system 'wget http://selenium-release.storage.googleapis.com/3.11/selenium-server-standalone-3.11.0.jar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('selenium-server-standalone-3.11.0.jar') ) == '5e6c9ed11e94bfb87407f7da2ebe0d1d609c1fa4d34c82108fc94b2509797312'
    system "install -Dm644 selenium-server-standalone-3.11.0.jar #{CREW_DEST_PREFIX}/share/selenium-server/selenium-server-standalone-3.11.0.jar"
    system "install -Dm755 startselenium #{CREW_DEST_PREFIX}/bin/startselenium"
    system "install -Dm755 stopselenium #{CREW_DEST_PREFIX}/bin/stopselenium"
  end

  def self.postinstall
    puts
    puts "To start/stop selenium server, execute the following:".lightblue
    puts "startselenium - starts selenium server".lightblue
    puts "stopselenium - stops selenium server".lightblue
    puts
  end
end
