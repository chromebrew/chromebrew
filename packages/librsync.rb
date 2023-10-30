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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2-1_armv7l/librsync-2.3.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2-1_armv7l/librsync-2.3.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2-1_i686/librsync-2.3.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/librsync/2.3.2-1_x86_64/librsync-2.3.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '28eec7479ef645f14297d3fc1d1db80bdf8d054ed78888ecd391f8804f2c0805',
     armv7l: '28eec7479ef645f14297d3fc1d1db80bdf8d054ed78888ecd391f8804f2c0805',
       i686: '4cfbee60f557730067df22e16da76b73d6a4170fbde1403fb78373a8f82d2103',
     x86_64: 'fdcbab57b6c0ca16bbcb83a5d33577b6655d49c1ab3b8d86b243957f6ba76c05'
  })

  depends_on 'cmake' => :build
  depends_on 'bzip2'
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
