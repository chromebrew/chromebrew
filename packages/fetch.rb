require 'package'

class Fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch/'
  @_ver = '0.4.2'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/gruntwork-io/fetch.git'
  git_hashtag 'v' + @_ver

  depends_on 'go'

  def self.build
    system "go get github.com/urfave/cli"
    system "go get github.com/hashicorp/go-version"
    system "sed -i 's,codegangsta,urfave,g' main.go"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "go build -ldflags \"-X main.VERSION=v#{@_ver}\" -o #{CREW_DEST_PREFIX}/bin/go-fetch"
  end
end
