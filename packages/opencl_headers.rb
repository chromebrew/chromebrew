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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_headers/2022.01.04_armv7l/opencl_headers-2022.01.04-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_headers/2022.01.04_armv7l/opencl_headers-2022.01.04-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_headers/2022.01.04_i686/opencl_headers-2022.01.04-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_headers/2022.01.04_x86_64/opencl_headers-2022.01.04-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f0b12ec6ee2767ea73ed54471e561265056d4fb77487b5b4c87200fd19498623',
     armv7l: 'f0b12ec6ee2767ea73ed54471e561265056d4fb77487b5b4c87200fd19498623',
       i686: 'df5da693a74ad37afb6994e6d63aa7286b851204962add65f89ab67bad15d724',
     x86_64: '61327f01cbe562dcebccf9dc2355e09bfb34f560b51512bb55e9085d7045686b'
  })

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
