require 'package'

class Libgit2 < Package
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  @_ver = '1.4.2'
  version @_ver
  license 'GPL-2-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/libgit2/libgit2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.4.2_armv7l/libgit2-1.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.4.2_armv7l/libgit2-1.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.4.2_i686/libgit2-1.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgit2/1.4.2_x86_64/libgit2-1.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8f893a29c3c3cf66a868fe6a02fe60f20c854d1b1b0dc5585550df52947679fb',
     armv7l: '8f893a29c3c3cf66a868fe6a02fe60f20c854d1b1b0dc5585550df52947679fb',
       i686: '328bb033fc1eaf16bac59a5b84264c7d138bc2d40750c6af78419e1c59ef286f',
     x86_64: 'f9db9f7f7cf14110f58447f7fada36b6f6b137a5b11fcf1eadc9218fc2b89e7e'
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
