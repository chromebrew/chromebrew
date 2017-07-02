require 'package'

class Sbt < Package
  description 'A build tool for Scala, Java and more.'
  homepage 'http://www.scala-sbt.org/'
  version '0.13.15'
  source_url 'https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz'
  source_sha256 'b6e073d7c201741dcca92cfdd1dd3cd76c42a47dc9d8c8ead8df7117deed7aef'

  depends_on 'jdk8'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/share/sbt/bin"
    system "install", "-m", "644", "bin/sbt-launch.jar", "#{CREW_DEST_DIR}/usr/local/share/sbt/bin"
    system "install", "-m", "644", "bin/sbt-launch-lib.bash", "#{CREW_DEST_DIR}/usr/local/share/sbt/bin"
    system "install", "-m", "755", "bin/sbt", "#{CREW_DEST_DIR}/usr/local/share/sbt/bin"

    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/share/sbt/conf"
    system "install", "-m", "644", "conf/sbtopts", "#{CREW_DEST_DIR}/usr/local/share/sbt/conf"

    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/bin"
    system "ln", "-s", "/usr/local/share/sbt/bin/sbt", "#{CREW_DEST_DIR}/usr/local/bin/sbt"

    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/etc/sbt"
    system "ln", "-s", "/usr/local/share/sbt/conf/sbtopts", "#{CREW_DEST_DIR}/usr/local/etc/sbt/sbtopts"
  end
end
