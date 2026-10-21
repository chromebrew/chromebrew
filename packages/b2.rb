require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.6.0'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '463c25da1afe35c727d70649811a0fcd59a753f6136b5afc5e0cef0afa1ac814',
     armv7l: '463c25da1afe35c727d70649811a0fcd59a753f6136b5afc5e0cef0afa1ac814',
       i686: 'dbbea29f6c90a94f1b97e7de3e03ef7d7285bf46aa3a33a267478d16ea2173dc',
     x86_64: '078449f6db318b389c594c4e24f6191e37a011aead976afa8544d914d1a0098a'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
