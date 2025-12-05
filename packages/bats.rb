require 'package'

class Bats < Package
  description 'Bash Automated Testing System'
  homepage 'https://github.com/bats-core/bats-core'
  version '1.13.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/bats-core/bats-core.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d4611b3b3edb932d5ab561ba026530a442790ae0a49f3250360d5a808a5c5e4',
     armv7l: '3d4611b3b3edb932d5ab561ba026530a442790ae0a49f3250360d5a808a5c5e4',
       i686: '9ed3dbf1660222836086d6a6bee6325bbc83945792f789ad89f533bf4bd24993',
     x86_64: 'dd3909855f57b21b3dcb0ed284f516f5292225843d8fed79f45da32ee85f9aea'
  })

  def self.install
    system "./install.sh #{CREW_DEST_PREFIX} #{ARCH_LIB}"
  end
end
