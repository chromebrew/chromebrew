require 'package'

class Go_fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch/'
  version '0.4.6'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/gruntwork-io/fetch.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae4c664cdc479f79ad98c5a498b5af3a58182baaaf0b464ca801e5ff29872317',
     armv7l: 'ae4c664cdc479f79ad98c5a498b5af3a58182baaaf0b464ca801e5ff29872317',
       i686: '055a7501d381aa0d0562df27d0d3a2202300714f48b92d6752db7eadeaf9f78c',
     x86_64: '9e6e60e4f3667bc8e6c200e6de71c4df29652837e59d9acc9e21fba11a3e598c'
  })

  depends_on 'glibc' # R
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
