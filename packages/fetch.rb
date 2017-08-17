require 'package'

class Fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch'
  version '0.1.1'
  source_url 'https://github.com/gruntwork-io/fetch/archive/v0.1.1.tar.gz'
  source_sha256 'ff3072da89c36a5031a3585ec6898113005185e76f626cf4ca8cffee4b62446d'

  depends_on 'go'

  def self.build
    system "go get github.com/urfave/cli"
    system "go get github.com/hashicorp/go-version"
    system "sed -i 's,codegangsta,urfave,g' main.go"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "go build -ldflags \"-X main.VERSION=v0.1.1\" -o #{CREW_DEST_DIR}/usr/local/bin/fetch"
  end
end
