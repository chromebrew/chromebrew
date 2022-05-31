require 'package'

class Neofetch < Package
  description 'A fast, highly customizable system info script'
  homepage 'https://github.com/dylanaraps/neofetch'
  version '7.1.0-ccd5'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://github.com/dylanaraps/neofetch.git'
  git_hashtag 'ccd5d9f52609bbdcd5d8fa78c4fdb0f12954125f'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-ccd5_i686/neofetch-7.1.0-ccd5-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-ccd5_x86_64/neofetch-7.1.0-ccd5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'd3135a635671605f5747e47779626b9185e1d0a3fe7ef8166b689bd13196b9c6',
  x86_64: '30ab2f9afee217da47cdd8daaab26b5a204288c6a8efab5e19627c96ea273e76'
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
