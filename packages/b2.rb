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
    aarch64: '4d40866bb6f1fef788860909cd6b99b73c9742d853c0847fd29d079e2b7929c2',
     armv7l: '4d40866bb6f1fef788860909cd6b99b73c9742d853c0847fd29d079e2b7929c2',
       i686: 'c698a9888d2c2b6f45d1acb7affe1b8ddf783cfa1ab0225b0a8a875b3abbba84',
     x86_64: 'eaa28d45779cc0bbbae1556ec1332229f3e7c5792158a36f5b8922ffc172c6c4'
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
