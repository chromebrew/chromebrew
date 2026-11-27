require 'package'

class Gopeed < Package
  description 'A modern download manager built with Golang and Flutter.'
  homepage 'https://gopeed.com/'
  version '2.0.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/GopeedLab/gopeed.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a23016b2e8b5fcf1f673de91060d6098a3502dadb6480fdbb27b8768107f34df',
     armv7l: 'a23016b2e8b5fcf1f673de91060d6098a3502dadb6480fdbb27b8768107f34df',
       i686: 'e47a27286242a23156f6d7a38c0f711ed4ab5775b3e3267619272b86f6555b2f',
     x86_64: 'd061b8ca00271452f2cb81da0b8638abfb5e7b3d6edeaf6b9c9587768d0c3d80'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "go build -C cmd/gopeed -o #{CREW_DEST_PREFIX}/bin/gopeed"
  end
end
