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
    aarch64: '7d9ae694a3df31802075f15af16567bc581935a7450033e03d99e4aed0b5612a',
     armv7l: '7d9ae694a3df31802075f15af16567bc581935a7450033e03d99e4aed0b5612a',
       i686: 'f70cdb95ad0fc91feaf82951f33c5ede10fac0d394bed7a61724e9e70fa21a6f',
     x86_64: '91e9dc1e77208544b9a9ba60f7e633bc7c3cd5b289e463a67675f968307610b8',
  })

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
