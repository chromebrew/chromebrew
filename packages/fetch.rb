require 'package'

class Fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch'
  version '0.1.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/gruntwork-io/fetch/archive/v0.1.1.tar.gz'
  source_sha256 'ff3072da89c36a5031a3585ec6898113005185e76f626cf4ca8cffee4b62446d'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/0.1.1_armv7l/fetch-0.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/0.1.1_armv7l/fetch-0.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/0.1.1_i686/fetch-0.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fetch/0.1.1_x86_64/fetch-0.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6df3fe6ab4d7a6277577275e49c973949b2e60e8f1516e7eca7ff72bf8f4ce7f',
     armv7l: '6df3fe6ab4d7a6277577275e49c973949b2e60e8f1516e7eca7ff72bf8f4ce7f',
       i686: '6daecf37b9ee3ad15cf7b30172b46a13ae84a8909edbbd09f48c9eeafdc07cec',
     x86_64: '572f35ff3eec1fc6ee50b70bd65d236bf9aff901e7c12adce0af82fcb07d2706',
  })

  depends_on 'go'

  def self.build
    system "go get github.com/urfave/cli"
    system "go get github.com/hashicorp/go-version"
    system "sed -i 's,codegangsta,urfave,g' main.go"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "go build -ldflags \"-X main.VERSION=v0.1.1\" -o #{CREW_DEST_PREFIX}/bin/fetch"
  end
end
