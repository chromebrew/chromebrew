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
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-ccd5_x86_64/neofetch-7.1.0-ccd5-chromeos-x86_64.tar.zst',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-ccd5_armv7l/neofetch-7.1.0-ccd5-chromeos-armv7l.tar.zst',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neofetch/7.1.0-ccd5_armv7l/neofetch-7.1.0-ccd5-chromeos-armv7l.tar.zst'
  })
  binary_sha256({
    i686: '5a35006bcec52e81d2ae60de414207fee83828f15e48962337f4613b963dd72a',
  x86_64: 'fc648c0dd5701a96143247dc190e4474823ecb9c687a0de02274c822746ca6b7',
 aarch64: 'c0957fdd5975660a493075dd6636c91ba55a29e1fc59760e51c9691d0d49ea5f',
  armv7l: 'c0957fdd5975660a493075dd6636c91ba55a29e1fc59760e51c9691d0d49ea5f'
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "PREFIX=#{CREW_PREFIX}", 'install'
  end
end
