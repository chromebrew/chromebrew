require 'package'

class Gb < Package
  description 'A project based build tool for the Go programming language.'
  homepage 'https://getgb.io/'
  version '0.4.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/constabulary/gb/archive/v0.4.4.tar.gz'
  source_sha256 'c7993ae1994ad85cbe35b833d36a137772599fe7ed720edec2d76ebf3fc4313b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gb/0.4.4_armv7l/gb-0.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gb/0.4.4_armv7l/gb-0.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gb/0.4.4_i686/gb-0.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gb/0.4.4_x86_64/gb-0.4.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '642e7da9d928bc40190a8265c4ea816c18249c8ed16d25a7819f6fc1bb682c0b',
     armv7l: '642e7da9d928bc40190a8265c4ea816c18249c8ed16d25a7819f6fc1bb682c0b',
       i686: 'bc36ed10b5a2cfa56349eb6f987434042c165d27225803a29bade0299c7a8935',
     x86_64: 'a2dd8c25947630b4aefd78ac0d7c38a31bf5db0995b44028e735e781f6253738'
  })

  depends_on 'go'

  def self.install
    system "SAVEGOPATH=$GOPATH && \
            export GOPATH=#{CREW_DEST_PREFIX}/share/gb && \
            go get -v github.com/constabulary/gb/... && \
            export GOPATH=$SAVEGOPATH"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      File.write 'gb', <<~EOF, perm: 0o755
        #!/bin/bash
        if [ -z "$GOPATH" ]; then
          echo "GOPATH environment variable not set."
          exit 1
        fi
        cd #{CREW_PREFIX}/share/gb
        bin/gb "$@"
      EOF

      File.write 'gb-vendor', <<~EOF, perm: 0o755
        #!/bin/bash
        if [ -z "$GOPATH" ]; then
          echo "GOPATH environment variable not set."
          exit 1
        fi
        cd #{CREW_PREFIX}/share/gb
        bin/gb-vendor "$@"
      EOF
    end
  end
end
