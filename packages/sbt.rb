require 'package'

class Sbt < Package
  description 'A build tool for Scala, Java and more.'
  homepage 'http://www.scala-sbt.org/'
  version '0.13.15'
  compatibility 'all'
  source_url 'https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz'
  source_sha256 'b6e073d7c201741dcca92cfdd1dd3cd76c42a47dc9d8c8ead8df7117deed7aef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sbt-0.13.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sbt-0.13.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sbt-0.13.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sbt-0.13.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e03f09d30d285e58766e9b22714e0c738502b9354fc4abeb067fd9b7575b882d',
     armv7l: 'e03f09d30d285e58766e9b22714e0c738502b9354fc4abeb067fd9b7575b882d',
       i686: '5e5ef2ba7df968391227ef30fd35517cf9da236a40852d92dfe34a643e456b42',
     x86_64: 'f5b3e18adb0253ab7905bc05fb4e9999e9db69df5a584537c7ad04713f4f8cb6',
  })

  depends_on 'jdk8'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/sbt/bin"
    system "install", "-m", "644", "bin/sbt-launch.jar", "#{CREW_DEST_PREFIX}/share/sbt/bin"
    system "install", "-m", "644", "bin/sbt-launch-lib.bash", "#{CREW_DEST_PREFIX}/share/sbt/bin"
    system "install", "-m", "755", "bin/sbt", "#{CREW_DEST_PREFIX}/share/sbt/bin"

    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/sbt/conf"
    system "install", "-m", "644", "conf/sbtopts", "#{CREW_DEST_PREFIX}/share/sbt/conf"

    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "ln", "-s", "#{CREW_PREFIX}/share/sbt/bin/sbt", "#{CREW_DEST_PREFIX}/bin/sbt"

    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/etc/sbt"
    system "ln", "-s", "#{CREW_PREFIX}/share/sbt/conf/sbtopts", "#{CREW_DEST_PREFIX}/etc/sbt/sbtopts"
  end
end
