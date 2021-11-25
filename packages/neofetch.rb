require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '7.1.0-24b1'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://github.com/dylanaraps/neofetch.git'
  git_hashtag '24b1281f9a38d2ff94490adf7a7f720338e0eb15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-24b1_armv7l/neofetch-7.1.0-24b1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-24b1_armv7l/neofetch-7.1.0-24b1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-24b1_i686/neofetch-7.1.0-24b1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-24b1_x86_64/neofetch-7.1.0-24b1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '904555a596e7c8b8cdbdb14e1437e45f99f903c6a002fdd3297b46976267658e',
     armv7l: '904555a596e7c8b8cdbdb14e1437e45f99f903c6a002fdd3297b46976267658e',
       i686: '5a35006bcec52e81d2ae60de414207fee83828f15e48962337f4613b963dd72a',
     x86_64: 'fc648c0dd5701a96143247dc190e4474823ecb9c687a0de02274c822746ca6b7'
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
