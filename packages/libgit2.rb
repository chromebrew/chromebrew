require 'package'

class Libgit2 < Package
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  @_ver = '1.5.0'
  version @_ver
  license 'GPL-2-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/libgit2/libgit2.git'
  git_hashtag "v#{@_ver}"

  depends_on 'glibc' # R
  depends_on 'libssh2' # R
  depends_on 'openssl' # R
  depends_on 'pcre' # R
  depends_on 'python3' # L
  depends_on 'zlibpkg' # R

  def self.build
    system "cmake -B builddir -G Ninja #{CREW_CMAKE_OPTIONS} \
              -DUSE_SSH=ON \
              -DUSE_BUNDLED_ZLIB=OFF \
              -Wno-dev"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    # Tests #3 and #8 fail in containers
    system 'samu -C builddir test || true'
  end
end
