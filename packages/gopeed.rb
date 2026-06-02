require 'package'

class Gopeed < Package
  description 'A modern download manager built with Golang and Flutter.'
  homepage 'https://gopeed.com/'
  version '1.9.3'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/GopeedLab/gopeed.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f0999e2f90a1fce01a546531318ca1d4099694c790d27f32c72f7deff4bf006',
     armv7l: '3f0999e2f90a1fce01a546531318ca1d4099694c790d27f32c72f7deff4bf006',
       i686: '28452e85ec958e49a5dc2ca5880367182e104b08478c2aaa17bc933cbf876c9c',
     x86_64: 'ea380ec06d2f15ef422b974c82cd04bd8c1b239eb64c01c552a87216ae273109'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "go build -C cmd/gopeed -o #{CREW_DEST_PREFIX}/bin/gopeed"
  end
end
