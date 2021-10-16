require 'package'

class Librsync < Package
  description 'remote delta-compression library'
  homepage 'https://librsync.github.io/'
  @_ver = '2.3.2'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/librsync/librsync.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2_armv7l/librsync-2.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2_armv7l/librsync-2.3.2-chromeos-armv7l.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2-1_x86_64/librsync-2.3.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b90a721754a98a77666b6aeaf4e76992e2ccfc3894bc44a61217306186b900d8',
     armv7l: 'b90a721754a98a77666b6aeaf4e76992e2ccfc3894bc44a61217306186b900d8',
    x86_64: 'fdcbab57b6c0ca16bbcb83a5d33577b6655d49c1ab3b8d86b243957f6ba76c05'
  })

  depends_on 'cmake' => :build
  depends_on 'bz2'
  depends_on 'perl'
  depends_on 'popt'
  depends_on 'zlibpkg'

  def self.build
    system "cmake -G Ninja . #{CREW_CMAKE_OPTIONS}"
    system 'samu'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu install"
  end
end
