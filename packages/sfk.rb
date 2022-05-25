require 'package'

class Sfk < Package
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'http://swissfileknife.sourceforge.net/'
  version '1.8.7'
  license 'BSD'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/swissfileknife/files/1-swissfileknife/1.8.7/sfk-1.8.7.tar.gz'
  source_sha256 '1c53d4d9d05af752546c8341a718bf64be99b62491ff91db02ef100e2f93bfc3'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sfk/1.8.7_armv7l/sfk-1.8.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sfk/1.8.7_armv7l/sfk-1.8.7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sfk/1.8.7_i686/sfk-1.8.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sfk/1.8.7_x86_64/sfk-1.8.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1666f3bd5271973be9ce535e6cc1a71a831ba3d479ba2a08b7c587d2142ef360',
     armv7l: '1666f3bd5271973be9ce535e6cc1a71a831ba3d479ba2a08b7c587d2142ef360',
       i686: 'e2366c801933f920eef6058c559883be2ab31470f314c0fc0bdd40187014331c',
     x86_64: '86c8b0fc3953d74b5225e16aec90dfb8e5c6f794f4d02ffb731e8ab8469c97e6'
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
