require 'package'

class Txt2man < Package
  description 'Txt2man converts flat ASCII text to man page format.'
  homepage 'https://github.com/mvertes/txt2man'
  version '1.7.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mvertes/txt2man.git'
  git_hashtag "txt2man-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '088f022b2a91fcd9c1126a99b087478d66946bac6a6d5d420fa7c68b97728c53',
     armv7l: '088f022b2a91fcd9c1126a99b087478d66946bac6a6d5d420fa7c68b97728c53',
       i686: '5085b7da6a41d4813e27a621222b5ceafb6bc2c7f08edf93c892c5dc1580a1e4',
     x86_64: '7f5ba97362f6b1bcdf61add2867acac9163f8d7b7d06141c52eb4db7d430bda2'
  })

  def self.build
    system 'make', "prefix=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "prefix=#{CREW_DEST_PREFIX}", 'install'
  end
end
