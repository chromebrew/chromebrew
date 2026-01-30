require 'package'

class Iw < Package
  description 'iw is a new nl80211 based CLI configuration utility for wireless devices.'
  homepage 'https://wireless.wiki.kernel.org/en/users/documentation/iw'
  version '6.17'
  license 'ISC'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f65cd3f859b5745625cb8998b22e2899d1b708a7948fcbb26d61fa8fd833a0e2',
     armv7l: 'f65cd3f859b5745625cb8998b22e2899d1b708a7948fcbb26d61fa8fd833a0e2',
       i686: '74020b7325f7ca7f32a764f5e4438e9923f6edb38e20ae1b036f61415aaa8843',
     x86_64: 'f8d182e34944226a9e52b525054b4ce70c603b06bd17acfa7d735f01658b570c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libnl3'

  def self.patch
    system "sed -i 's:/usr:#{CREW_PREFIX}:g' Makefile" # Change prefix to CREW_PREFIX
  end

  def self.build
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
