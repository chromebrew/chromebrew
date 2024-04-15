require 'package'

class Gopeed < Package
  description 'A modern download manager built with Golang and Flutter.'
  homepage 'https://gopeed.com/'
  version '1.5.6'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/GopeedLab/gopeed/v1.5.6/README.md'
  source_sha256 '2bdd36245d85f95c86a540e9602e47550571b753e2563c28952d009b2d0804fc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58b7d1e4c821d1ddf44e579f1bc810aba61c0b4a52199281d7f89a6cb587cee4',
     armv7l: '58b7d1e4c821d1ddf44e579f1bc810aba61c0b4a52199281d7f89a6cb587cee4',
     x86_64: 'dbd4c5f56f388859dea97d1a693291cb5e3c6c43309bc85c80c61d956deb97f2',
       i686: 'ecd62ca0b1b2e2443e5ad1fc462aaa5f6958dd749d674aff8eaecf2c8d3349a8'
  })

  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/GopeedLab/gopeed/cmd/gopeed@v#{version}"
  end
end
