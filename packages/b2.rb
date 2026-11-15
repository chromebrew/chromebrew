require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.6.1'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44c0422643c0d3ffec9c8f0d5d6859d9b3e322189353cf61288ed5760cdf5404',
     armv7l: '44c0422643c0d3ffec9c8f0d5d6859d9b3e322189353cf61288ed5760cdf5404',
       i686: '4921ee14783adcb18341373152b1794fed4b4ee2a112a4ec07029cbeb9560515',
     x86_64: '3a7c6b1ae396463fbb6e8252596f4f1ce9a6b8f1a2011c42180d4ffe0008b031'
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
