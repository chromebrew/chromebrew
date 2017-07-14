require 'package'

class Fuse < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  version '2.9.7'
  source_url 'https://github.com/libfuse/libfuse/releases/download/fuse-2.9.7/fuse-2.9.7.tar.gz'
  source_sha256 '832432d1ad4f833c20e13b57cf40ce5277a9d33e483205fc63c78111b3358874'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
