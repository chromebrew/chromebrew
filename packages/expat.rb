require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.5.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.5.0_armv7l/expat-2.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.5.0_armv7l/expat-2.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.5.0_i686/expat-2.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/expat/2.5.0_x86_64/expat-2.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80cde237aba35f24d0c245139f9da977ca7e9cf6ba567f7227227aabb33e5387',
     armv7l: '80cde237aba35f24d0c245139f9da977ca7e9cf6ba567f7227227aabb33e5387',
       i686: '83123fee8e066ae20d256587969d5e411ec22d605323c1a8fb1d12e3068db83f',
     x86_64: '5608360a9754d4c1c6932fccab28e13ff0cd5c735a77d28be14d1daefe0e13f3'
  })

  depends_on 'glibc' # R

  def self.build
    Dir.chdir('expat') do
      system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
          -DBUILD_SHARED_LIBS=ON \
          -Wno-dev \
          -G Ninja"
      system "mold -run #{CREW_NINJA} -C builddir"
    end
  end

  def self.check
    Dir.chdir('expat') do
      system "mold -run #{CREW_NINJA} -C builddir test"
    end
  end

  def self.install
    Dir.chdir('expat') do
      system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    end
  end
end
