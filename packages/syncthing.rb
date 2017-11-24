require 'package'

class Syncthing < Package
  description 'An application that lets you synchronize your files across multiple devices'
  homepage 'https://github.com/syncthing/syncthing'
  version '0.14.40'
  source_url 'https://github.com/syncthing/syncthing/archive/v0.14.40.tar.gz'
  source_sha256 'b9820dceb472531f20ebd18ab53a66876970c9d78d22c93ff53c3c879363d6be'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'go' => build

  def self.build
    #The system tmp dir is mounted noexec, and the build will fail if it is used
    system "TMPDIR=/usr/local/tmp go run build.go -version v0.14.40"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mv bin/syncthing #{CREW_DEST_PREFIX}/bin"
    #The build process leaves 50M of files around that we do not need
    system "rm -rf /usr/local/tmp/syncthing-*/"
  end
end
