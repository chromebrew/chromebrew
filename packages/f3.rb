require 'package'

class F3 < Package
  description 'F3 is a simple tool that tests flash cards\' capacity and performance to see if they live up to claimed specifications.'
  homepage 'http://oss.digirati.com.br/f3/'
  version '10.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AltraMayor/f3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f0a8080737123b8c1e85d088f5912de3cb5d287c03f813799f2259ba3adde8',
     armv7l: 'a3f0a8080737123b8c1e85d088f5912de3cb5d287c03f813799f2259ba3adde8',
     x86_64: 'b0aece68398809efe3c01eacef9f2ea3f7aaad29f3c7ab81d214e6301f277dcf'
  })

  depends_on 'eudev' => :executable
  depends_on 'glibc' => :executable
  depends_on 'parted' => :executable

  def self.build
    system 'make'
    system 'make', 'extra'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-extra'
  end
end
