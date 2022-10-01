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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.0_armv7l/libgit2-1.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.0_armv7l/libgit2-1.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.0_i686/libgit2-1.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.5.0_x86_64/libgit2-1.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a047f829611f016ea6f1c2773838b4673446fded955049b849d402493e4de123',
     armv7l: 'a047f829611f016ea6f1c2773838b4673446fded955049b849d402493e4de123',
       i686: '467813edb1d605f8464780d366d5587633219a3d322ec6f1edef2c59bb20c47f',
     x86_64: '8401c5d508b5d25eb4c804eb79c3e1331f21643cd6192c655a88627c2c7a6e41'
  })

  depends_on 'python3'
  depends_on 'libssh2'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
              -DUSE_SSH=ON \
              -Wno-dev .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    # Tests #3 and #8 fail in containers
    # system 'samu -C builddir test'
  end
end
