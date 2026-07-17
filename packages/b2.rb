require 'package'

class B2 < Package
  description 'B2 makes it easy to build C++ projects, everywhere.'
  homepage 'https://www.bfgroup.xyz/b2/'
  version '5.5.3'
  license 'BSL 1.0'
  compatibility 'all'
  source_url 'https://github.com/bfgroup/b2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3ec0927c7f2eafd1911ffce69507241a8bfb8a8af7cf5b1e06b991c28d0a951',
     armv7l: 'a3ec0927c7f2eafd1911ffce69507241a8bfb8a8af7cf5b1e06b991c28d0a951',
       i686: 'f74abb6449b4e2f54c6a5919f2e6a0006b9a05c2e39032653f327a33e3b0a12f',
     x86_64: '46a9056673587783719782663ef78dd012e7e6503a1b72f986417d27233ca33e'
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
