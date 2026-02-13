require 'package'

class Go_fetch < Package
  description 'fetch makes it easy to download files, folders, or release assets from a specific commit, branch, or tag of a public or private GitHub repo.'
  homepage 'https://github.com/gruntwork-io/fetch/'
  version '0.4.8'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/gruntwork-io/fetch.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88b046562fb38601b38a4896a9b2b4410ca65fd43ad45ee4c17661bed64d2a4b',
     armv7l: '88b046562fb38601b38a4896a9b2b4410ca65fd43ad45ee4c17661bed64d2a4b',
       i686: '73b034d582bbfb473835c059703a93629f0008c88d7165391cabe6582a11b40b',
     x86_64: '01c299923ff02607bce592d382dc3a1539cd37c36fee0524ca80ff2be4bc41a5'
  })

  depends_on 'glibc' => :executable_only
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
