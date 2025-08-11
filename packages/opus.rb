require 'buildsystems/cmake'

class Opus < CMake
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'https://opus-codec.org'
  version '1.5.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opus.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ead0454198c22c46a00081547bccb566f63462b4e1cd190387ac11b6fa1830d4',
     armv7l: 'ead0454198c22c46a00081547bccb566f63462b4e1cd190387ac11b6fa1830d4',
       i686: '8bee7418ab52ca374f43a147958ec34083bc787c7c1337431160a5e75a27cc55',
     x86_64: 'e4ee10ea6f462011057f8b3c13557cd02a02adcff8c959d33aa3d19c0bdb4f41'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' # R

  def self.build
    @cmake_build_relative_dir = '.'
    system "cmake -S #{@cmake_build_relative_dir} -B #{@cmake_build_relative_dir}/builddir -G Ninja #{CREW_CMAKE_OPTIONS.gsub('vfpv3-d16', 'neon')} -DBUILD_TESTING=OFF \
    -DCUSTOM_MODES=ON \
    -DBUILD_SHARED_LIBS=ON"
    system "#{CREW_PREFIX}/bin/jobserver_pool.py -j #{CREW_NPROC} #{CREW_NINJA} -C #{@cmake_build_relative_dir}/builddir"
  end
end
