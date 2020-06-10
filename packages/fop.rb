require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.2'
  compatibility 'all'
  source_url 'http://apache.forsale.plus/xmlgraphics/fop/binaries/fop-2.2-bin.tar.gz'
  source_sha256 '9dc1f9d1cb9acf5b3352116924c0b7678a88703b1214d537bc027c6867ec4dfe'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ae3c47bba798fdc6a0eec6b613fb9f25d6015b27adb5845ab90ce46b16be0da',
     armv7l: '5ae3c47bba798fdc6a0eec6b613fb9f25d6015b27adb5845ab90ce46b16be0da',
       i686: '06c576e9fe57ff1efec61ae76a9f82c34f5def02c658e469866ad6256ef79ef5',
     x86_64: '84e05f40cee9b05976efe47579718b3eb6ffa5080e65a3aa98a558a8b46e1934',
  })

  depends_on 'jdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/fop"
    system "cp -r . #{CREW_DEST_LIB_PREFIX}/fop"
    system "chmod +x #{CREW_DEST_LIB_PREFIX}/fop/fop/fop"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > fop"
      system "echo 'PWD=$(pwd)' >> fop"
      system "echo 'cd #{CREW_LIB_PREFIX}/fop/fop' >> fop"
      system "echo './fop \"$@\"' >> fop"
      system "echo 'cd $PWD' >> fop"
      system "chmod +x fop"
    end
  end

  def self.postinstall
    puts
    puts "To complete the installation, set the environment variable as follows:".lightblue
    puts "echo 'export JAVA_HOME=#{CREW_LIB_PREFIX}/jdk8' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
