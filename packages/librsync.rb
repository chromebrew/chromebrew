require 'package'

class Librsync < Package
  description 'remote delta-compression library'
  homepage 'https://librsync.github.io/'
  @_ver = '2.3.2'
  version @_ver + '-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/librsync/librsync.git'
  git_hashtag 'v' + @_ver

  depends_on 'cmake' => :build
  depends_on 'bz2'
  depends_on 'perl'
  depends_on 'popt'
  depends_on 'zlibpkg'

  def self.build
    system "cmake -G Ninja . #{CREW_CMAKE_OPTIONS}"
    system "samu"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu install"
  end
end
