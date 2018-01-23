require 'package'

class Sejda_console < Package
  description 'Sejda SDK is an open source, task oriented Java library to edit PDF files.'
  homepage 'http://sejda.org/'
  version '3.2.43'
  source_url 'https://github.com/torakiki/sejda/releases/download/v3.2.43/sejda-console-3.2.43-bin.zip'
  source_sha256 '0d1c5e9e5857332cc50a881e6ab6f2051ebd8ae04f8421f6865c38b9f14dd67c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.43-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.43-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.43-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sejda_console-3.2.43-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '28de2bf7e8b6b5edd1534334729e88c1c2f7611debc8ad443c80660b4659d420',
     armv7l: '28de2bf7e8b6b5edd1534334729e88c1c2f7611debc8ad443c80660b4659d420',
       i686: 'ef5a2804b143f13123f83a5f1e2741f3e20d11f3fcdb9bca455239009b7aab48',
     x86_64: 'd462f3d37b2f0ecb9657a20f983e70e13ff261bd75046d260c6dc99d1171c632',
  })
  
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
