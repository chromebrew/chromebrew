require 'package'

class Iw < Package
  description 'iw is a new nl80211 based CLI configuration utility for wireless devices.'
  homepage 'https://wireless.wiki.kernel.org/en/users/documentation/iw'
  version '5.9'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/snapshot/iw-5.9.tar.gz'
  source_sha256 'f38a82a9bfa2a45d6bf471fe84df9c39bed3d3ca0e8931ed31951f603e21deb3'

  depends_on 'libnl3'
  
  def self.patch
    system "sed -i 's:usr:#{CREW_PREFIX}:g' Makefile" # Change prefix to CREW_PREFIX
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
