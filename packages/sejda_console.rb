require 'package'

class Sejda_console < Package
  description 'Sejda SDK is an open source, task oriented Java library to edit PDF files.'
  homepage 'http://sejda.org/'
  version '3.2.46'
  compatibility 'all'
  source_url 'https://github.com/torakiki/sejda/releases/download/v3.2.46/sejda-console-3.2.46-bin.zip'
  source_sha256 '11654d11f15f41d9f3c54ee90efd8477687193c1cb7b1f40db69d901e9cbde2f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.46-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.46-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.46-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.46-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '965091442b3eac498452b3df15cfc7ce84b144a13e83a460272a52a271751105',
     armv7l: '965091442b3eac498452b3df15cfc7ce84b144a13e83a460272a52a271751105',
       i686: '377228a512d3f78a487f34843169fe5f9e829ee64d24f4f87e795de3221e2966',
     x86_64: 'd59742c678df678145d00a86e82dca8ffa180299f099eafbc674d76641ea9506',
  })

  depends_on 'help2man' => :build
  depends_on 'unzip' => :build
  depends_on 'jdk8'

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
    system "help2man -N --no-discard-stderr sejda-console > #{CREW_DEST_PREFIX}/man/man1/sejda-console.1"
  end
end
