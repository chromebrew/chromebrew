require 'package'

class Sejda_console < Package
  description 'Sejda SDK is an open source, task oriented Java library to edit PDF files.'
  homepage 'http://sejda.org/'
  version '3.2.17'
  source_url 'https://github.com/torakiki/sejda/releases/download/v3.2.17/sejda-console-3.2.17-bin.zip'
  source_sha256 '62476a7985c7c272fc036b07d2b16dbeb8dfb0167f202f5d1c6d557fe14137ac'

  depends_on 'help2man'
  depends_on 'jdk8'
  depends_on 'unzip'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/sejda_console"
    system "cp -r . #{CREW_DEST_DIR}/usr/local/share/sejda_console"
    FileUtils.cd("#{CREW_DEST_DIR}/usr/local/bin") do
      system "echo '#!/bin/bash' > sejda-console"
      system "echo 'PWD=$(pwd)' >> sejda-console"
      system "echo 'cd /usr/local/share/sejda_console' >> sejda-console"
      system "echo 'bin/sejda-console $1 $2 $3 $4 $5 $6 $7 $8 $9' >> sejda-console"
      system "echo 'cd $PWD' >> sejda-console"
      system "chmod +x sejda-console"
    end
    system "cp #{CREW_DEST_DIR}/usr/local/bin/sejda-console /usr/local/bin"
    system "help2man -N sejda-console > #{CREW_DEST_DIR}/usr/local/man/man1/sejda-console.1"
  end
end
