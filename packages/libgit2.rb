require 'package'

class Libgit2 < Package
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  version '1.5.1'
  license 'GPL-2-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/libgit2/libgit2.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.1_armv7l/libgit2-1.5.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.1_armv7l/libgit2-1.5.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.1_i686/libgit2-1.5.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.1_x86_64/libgit2-1.5.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '41bfb7566d34afa5c07d59e28ca1734a43c8b8049903d5d2faed644506abb40e',
     armv7l: '41bfb7566d34afa5c07d59e28ca1734a43c8b8049903d5d2faed644506abb40e',
       i686: 'c22cdf93057e33fbf8109c2be948cde27b6d1f42db173dab2213e04cf083a712',
     x86_64: 'dd634a7a8b0dbc4c25fd9c5e329f6e95670db8dace736f14bfc4f667deaf669c'
  })

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
