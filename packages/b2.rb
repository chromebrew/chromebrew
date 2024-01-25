require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '4.4.1'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/boostorg/build/archive/refs/tags/4.4.1.tar.gz'
  source_sha256 '31a243b1eb26638500977a8386e56d44f86c18db70cf0a5dcdd2d7391afc1a61'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'e569052575f2ea9cca33f7fc6b1bfd95a8fb3a6366da44142f51c99a71b377ed',
     armv7l: 'e569052575f2ea9cca33f7fc6b1bfd95a8fb3a6366da44142f51c99a71b377ed',
       i686: '108b05f8acd6c4f5b0b9748fe274a7d439dfd2bf52ea1a37bee8eca936a542c5',
     x86_64: '545ab9a0d26e0abe5296a7913ea7d0ded9caea6592f1cf7cd623d290e7f96343'
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
