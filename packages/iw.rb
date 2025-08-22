require 'package'

class Iw < Package
  description 'iw is a new nl80211 based CLI configuration utility for wireless devices.'
  homepage 'https://wireless.wiki.kernel.org/en/users/documentation/iw'
  version '6.9'
  license 'ISC'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '036fd416b734ff209e72e69f9ae47a51956e3a2f1ddff7ba1b7e53eaa824ed2f',
     armv7l: '036fd416b734ff209e72e69f9ae47a51956e3a2f1ddff7ba1b7e53eaa824ed2f',
       i686: 'af8ad685b5578cc5a960ccebffeccf7c720fb8cb880161224fbb3ff439249c47',
     x86_64: 'e5009956bb7fb6f74075f22e87057cfeca8adc2e2549fafdc37fac2bd7251854'
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
