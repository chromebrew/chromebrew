require 'package'

class Sejda_console < Package
  description 'Sejda SDK is an open source, task oriented Java library to edit PDF files.'
  homepage 'http://sejda.org/'
  version '3.2.22'
  source_url 'https://github.com/torakiki/sejda/releases/download/v3.2.22/sejda-console-3.2.22-bin.zip'
  source_sha256 '09379d7f89d6b373a39d3e642a377650f0660849e8a934e2b94169df51dd7c13'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e0882ccd657298a953e15e5aa3225bc30ec149c8b20e67d1f5470490a225667',
     armv7l: '5e0882ccd657298a953e15e5aa3225bc30ec149c8b20e67d1f5470490a225667',
       i686: '4faf168ee42419009062008f7d9bffe1f81b45072e4f1a934cedc80cbacb3b63',
     x86_64: 'a92065131f5167366f2dc265d142f89d50efaa61b396800dc27bfc976eb56cde',
  })

  depends_on 'help2man'
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
