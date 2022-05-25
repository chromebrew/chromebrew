require 'package'

class Libfmt < Package
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '9.0.0-c48be43'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt.git'
  git_hashtag 'c48be439f1ae03f2726e30ac93fce3a667dc4be2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/9.0.0-c48be43_armv7l/libfmt-9.0.0-c48be43-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/9.0.0-c48be43_armv7l/libfmt-9.0.0-c48be43-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/9.0.0-c48be43_i686/libfmt-9.0.0-c48be43-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/9.0.0-c48be43_x86_64/libfmt-9.0.0-c48be43-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '46077930c6984ac1da70868a6fda98f3a1eb6cf0e45e6ca5b0c3be1b39b18c9a',
     armv7l: '46077930c6984ac1da70868a6fda98f3a1eb6cf0e45e6ca5b0c3be1b39b18c9a',
       i686: '21aa870bf1073526eb30e2e3f4268a2dc150a92aee33a912a2caed73c485c2fd',
     x86_64: '4728da91e5b944a97df30e5ee8c91816a1bb1dc2854f49846584fc90d5c1812b'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake #{CREW_CMAKE_OPTIONS} \
              -DBUILD_SHARED_LIBS=TRUE \
              .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.check
    Dir.chdir 'builddir' do
      system 'make', 'test'
    end
  end
end
