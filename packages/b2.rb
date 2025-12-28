require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.4.2'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fb0969ed19d32d7a5ff4aa17818a6520c8b07be012b68158996e05d77658829',
     armv7l: '4fb0969ed19d32d7a5ff4aa17818a6520c8b07be012b68158996e05d77658829',
       i686: 'b64616fd92e5930cec29d16a045618ad81a768b47d398c3501b176590783023c',
     x86_64: 'e25331d87cd4b8c738c372b8cd8bd1750885fc33208bf2d87416a595ae56e51f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 install --prefix=#{CREW_DEST_PREFIX}"
  end
end
