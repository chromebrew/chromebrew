require 'package'

class Gb < Package
  description 'A project based build tool for the Go programming language.'
  homepage 'https://getgb.io/'
  version '0.4.4'
  source_url 'https://github.com/constabulary/gb/archive/v0.4.4.tar.gz'
  source_sha256 'c7993ae1994ad85cbe35b833d36a137772599fe7ed720edec2d76ebf3fc4313b'

  binary_url ({
  })
  binary_sha256 ({
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
