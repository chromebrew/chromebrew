require 'package'

class Sejda_console < Package
  description 'Sejda SDK is an open source, task oriented Java library to edit PDF files.'
  homepage 'http://sejda.org/'
  version '3.2.46'
  source_url 'https://github.com/torakiki/sejda/releases/download/v3.2.46/sejda-console-3.2.46-bin.zip'
  source_sha256 '11654d11f15f41d9f3c54ee90efd8477687193c1cb7b1f40db69d901e9cbde2f'
  
  depends_on 'help2man' => :build
  depends_on 'jdk8'
  depends_on 'unzip'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/sejda_console"
    system "cp -r . #{CREW_DEST_PREFIX}/share/sejda_console"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > sejda-console"
      system "echo 'PWD=$(pwd)' >> sejda-console"
      system "echo 'cd #{CREW_PREFIX}/share/sejda_console' >> sejda-console"
      system "echo 'bin/sejda-console \"\$@\"' >> sejda-console"
      system "echo 'cd $PWD' >> sejda-console"
      system "chmod +x sejda-console"
    end
    system "cp #{CREW_DEST_PREFIX}/bin/sejda-console #{CREW_PREFIX}/bin"
    system "help2man -N sejda-console > #{CREW_DEST_PREFIX}/man/man1/sejda-console.1"
  end
end
