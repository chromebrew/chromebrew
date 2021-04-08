require 'package'

class Fop < Package
  description 'Apache FOP (Formatting Objects Processor) is a print formatter driven by XSL formatting objects (XSL-FO) and an output independent formatter.'
  homepage 'https://xmlgraphics.apache.org/fop/'
  version '2.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/xmlgraphics/fop/binaries/fop-2.6-bin.tar.gz'
  source_sha256 'ccfd7a1d4e5a04e76723946efa1147ffa9a8715ce2b58d2a27085a8e744520f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fop-2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f8039a905a4835c04589f45eeb6ce6bf7a0ad749e864897f0700b42741aef606',
     armv7l: 'f8039a905a4835c04589f45eeb6ce6bf7a0ad749e864897f0700b42741aef606',
       i686: '566372125c92d0678f203f84235e670a2fde61499dfd8c155d476fbce99c49e0',
     x86_64: '306a3da1d92fc9b4fab5124d46276142aee47af73ea0b9b96d6e6682ab1aa44d',
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
