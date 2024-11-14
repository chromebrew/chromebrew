require 'package'

class Go_fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch/'
  version '0.4.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/gruntwork-io/fetch.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b0e8b47876a76312e2ee23bbc436e1493eb04b8814389292888229369416cbbc',
     armv7l: 'b0e8b47876a76312e2ee23bbc436e1493eb04b8814389292888229369416cbbc',
       i686: '4aed282daea6af1217e0b9818fbbb6aea2cf09408057bf9da2c6bcd984a79bfe',
     x86_64: 'fc2f886eba2b7301b5a93b76a8b93a9c89175e486109a8f520c7c01df727e399'
  })

  depends_on 'go' => :build

  def self.build
    system 'go get github.com/urfave/cli'
    system 'go get github.com/hashicorp/go-version'
    system "sed -i 's,codegangsta,urfave,g' main.go"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "go build -ldflags \"-X main.VERSION=v#{version}\" -o #{CREW_DEST_PREFIX}/bin/go-fetch"
  end
end
