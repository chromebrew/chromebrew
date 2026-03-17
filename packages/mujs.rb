require 'package'

class Mujs < Package
  description 'An embeddable Javascript interpreter in C'
  homepage 'https://mujs.com/'
  version '1.3.9'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/mujs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6d0fda3ba3952a468b08e00e4ad99389d974d841c8c2063a570b55a026cd984',
     armv7l: 'b6d0fda3ba3952a468b08e00e4ad99389d974d841c8c2063a570b55a026cd984',
       i686: '92448403a79d77445d8726fac103de481913229f6e7ed65aa15cf4c2b91b2cf4',
     x86_64: 'ce14606a0e778e72f725353e2c247e8fe99aaa857d875648da3e9da727397464'
  })

  depends_on 'glibc' # R
  depends_on 'readline' => :executable_only

  def self.build
    system 'make', 'release'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install-shared'
  end
end
