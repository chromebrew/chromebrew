require 'package'

class Go_fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch/'
  version '0.4.9'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/gruntwork-io/fetch.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '162bd694eeb7330e095f998048f10d73ed3d88f06daa271a3840fa8bf334ca1d',
     armv7l: '162bd694eeb7330e095f998048f10d73ed3d88f06daa271a3840fa8bf334ca1d',
       i686: '40bfb9fcef9559f843ead07093cf1d166312825ce5a66d03248b7d814dbe8ace',
     x86_64: '982ae441bc2ddfcb54185aa1f483c2d4409b8cbae2db34d95cee6eef657465c6'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
