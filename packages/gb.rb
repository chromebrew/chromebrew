require 'package'

class Gb < Package
  description 'A project based build tool for the Go programming language.'
  homepage 'https://getgb.io/'
  version '0.4.4'
  compatibility 'all'
  source_url 'https://github.com/constabulary/gb/archive/v0.4.4.tar.gz'
  source_sha256 'c7993ae1994ad85cbe35b833d36a137772599fe7ed720edec2d76ebf3fc4313b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gb-0.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gb-0.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gb-0.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gb-0.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '642e7da9d928bc40190a8265c4ea816c18249c8ed16d25a7819f6fc1bb682c0b',
     armv7l: '642e7da9d928bc40190a8265c4ea816c18249c8ed16d25a7819f6fc1bb682c0b',
       i686: 'bc36ed10b5a2cfa56349eb6f987434042c165d27225803a29bade0299c7a8935',
     x86_64: 'a2dd8c25947630b4aefd78ac0d7c38a31bf5db0995b44028e735e781f6253738',
  })

  depends_on 'go'

  def self.install
    system "SAVEGOPATH=$GOPATH && \
            export GOPATH=#{CREW_DEST_PREFIX}/share/gb && \
            go get -v github.com/constabulary/gb/... && \
            export GOPATH=$SAVEGOPATH"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > gb"
      system "echo 'if [ -z \"\$GOPATH\" ]; then' >> gb"
      system "echo '  echo \"GOPATH environment variable not set.\"' >> gb"
      system "echo '  exit 1' >> gb"
      system "echo 'fi' >> gb"
      system "echo 'cd #{CREW_PREFIX}/share/gb' >> gb"
      system "echo 'bin/gb \"\$@\"' >> gb"
      system "echo 'cd -' >> gb"
      system "chmod +x gb"
      system "echo '#!/bin/bash' > gb-vendor"
      system "echo 'if [ -z \"\$GOPATH\" ]; then' >> gb-vendor"
      system "echo '  echo \"GOPATH environment variable not set.\"' >> gb-vendor"
      system "echo '  exit 1' >> gb-vendor"
      system "echo 'fi' >> gb-vendor"
      system "echo 'cd #{CREW_PREFIX}/share/gb' >> gb-vendor"
      system "echo 'bin/gb-vendor \"\$@\"' >> gb-vendor"
      system "echo 'cd -' >> gb-vendor"
      system "chmod +x gb-vendor"
    end
  end
end
