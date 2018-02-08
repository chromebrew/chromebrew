require 'package'

class Brotli < Package
  description 'Brotli compression format '
  homepage 'https://github.com/google/brotli'
  version '1.0.2'
  source_url 'https://github.com/google/brotli/archive/v1.0.2.tar.gz'
  source_sha256 'c2cf2a16646b44771a4109bb21218c8e2d952babb827796eb8a800c1f94b7422'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'caeba80019a2a67c9e4ad1a315346032081c7038a8b2584113f3bb736fb2398d',
     armv7l: 'caeba80019a2a67c9e4ad1a315346032081c7038a8b2584113f3bb736fb2398d',
       i686: 'c407302e52803695399398fac407cd094f0d11ff1d559b4c4ddceb6a5f1c72da',
     x86_64: 'f6c36378dcee4deb6ea8d9aeeb0bb2d21364d6bbda24847646be3b4eb1eb8f6b',
  })

  depends_on 'cmake' => :build

  def self.build
    system 'mkdir out'
    Dir.chdir 'out' do
      system "cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
      system "cmake --build . --config Release --target install"
    end
  end

  def self.install
    Dir.chdir 'out' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX} -P cmake_install.cmake"
    end
  end
end
