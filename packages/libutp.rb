require 'package'

class Libutp < Package
  description 'uTorrent Transport Protocol library'
  homepage 'https://github.com/bittorrent/libutp'
  version '2b364'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/bittorrent/libutp.git'
  git_hashtag '2b364cbb0650bdab64a5de2abb4518f9f228ec44'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04f0ef9310e00b2382a3d2c95f8c3b1827eb27d3137d4aaa1f57d2d945543660',
     armv7l: '04f0ef9310e00b2382a3d2c95f8c3b1827eb27d3137d4aaa1f57d2d945543660',
       i686: 'eac5760e46b5b3bcc8ce5d2166cac034d280823abe12b945968d7fa31e5674fa',
     x86_64: '967b9f4b06168af7b3d2ec5d780e5d83cb6e0e5f1612be940b04cd380be0c814'
  })

  def self.build
    system 'make all'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/utp"
    FileUtils.install %w[ucat ucat-static], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install %w[libutp.a libutp.so], CREW_DEST_LIB_PREFIX, mode: 0o644
    FileUtils.install Dir['*.h'], "#{CREW_DEST_PREFIX}/include/utp", mode: 0o644
  end
end
