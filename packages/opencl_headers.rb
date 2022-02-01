require 'package'

class Opencl_headers < Package
  description 'OpenCL header files'
  homepage 'https://github.com/KhronosGroup/OpenCL-Headers'
  @_ver = '2022.01.04'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-Headers.git'
  git_hashtag "v#{@_ver}"

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
