require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.5.1'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d70ef8429a76a863f0ef810aec0bb1d01365b8ac5f7d79e61526894b8275471',
     armv7l: '7d70ef8429a76a863f0ef810aec0bb1d01365b8ac5f7d79e61526894b8275471',
       i686: '5b0d60f16b8f0a78961c9b2a1feb4ffbe45b353a632d13c8dc9b67d8706cde22',
     x86_64: '63f0de3c978ddd357f8f50adee48b63b0f3406aad1796e96838d8f678558bff9'
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
