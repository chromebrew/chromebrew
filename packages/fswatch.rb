require 'package'

class Fswatch < Package
  description 'fswatch is a file change monitor that receives notifications when the contents of the specified files or directories are modified.'
  homepage 'https://github.com/emcrisostomo/fswatch'
  version '1.11.2'
  source_url 'https://github.com/emcrisostomo/fswatch/releases/download/1.11.2/fswatch-1.11.2.tar.gz'
  source_sha256 'b7dadb84848ce666aac0311f9b4c739fbfee6a90c6097807a1f45ad4367294c2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
