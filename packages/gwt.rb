require 'package'

class Gwt < Package
  description 'Google Web Toolkit'
  homepage 'http://www.gwtproject.org/'
  version '2.8.2'
  source_url 'https://storage.googleapis.com/gwt-releases/gwt-2.8.2.zip'
  source_sha256 '970701dacc55170088f5eb327137cb4a7581ebb4734188dfcc2fad9941745d1b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ant'
  depends_on 'unzip' => :build

  def self.install
    system "rm -f *.cmd"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/gwt"
    system "cp -r . #{CREW_DEST_PREFIX}/share/gwt"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system "echo '#!/bin/bash' > i18nCreator"
      system "echo 'cd #{CREW_PREFIX}/share/gwt' >> i18nCreator"
      system "echo './i18nCreator \"$@\"' >> i18nCreator"
      system "chmod +x i18nCreator"
      system "echo '#!/bin/bash' > webAppCreator"
      system "echo 'cd #{CREW_PREFIX}/share/gwt' >> webAppCreator"
      system "echo './webAppCreator \"$@\"' >> webAppCreator"
      system "chmod +x webAppCreator"
    end
  end

  def self.postinstall
    puts
    puts "To uninstall completely including projects, execute the following:".lightblue
    puts "crew remove gwt".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/gwt".lightblue
    puts
  end
end
