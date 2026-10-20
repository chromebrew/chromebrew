require 'package'

class Mujs < Package
  description 'An embeddable Javascript interpreter in C'
  homepage 'https://mujs.com/'
  version '1.3.11'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/ArtifexSoftware/mujs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ca589fd7367317ceb931dbd1f74f852a2d388a6534d899c69408f13ec928e30',
     armv7l: '0ca589fd7367317ceb931dbd1f74f852a2d388a6534d899c69408f13ec928e30',
       i686: '73cc5c1231274d9c6f5aa55ac5c137190b47e9ce3e520d2608d5c0f98606077d',
     x86_64: 'bea0c20d00f1c2d350abe29bfc81a6e086bfc8a2ae7e095d36824c67b9f3a10e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'readline' => :executable

  def self.build
    system 'make', 'release'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install-shared'
  end
end
