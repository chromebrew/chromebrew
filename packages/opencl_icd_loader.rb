require 'package'

class Opencl_icd_loader < Package
  description 'OpenCL Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/OpenCL-ICD-Loader'
  @_ver = '2022.01.04'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-ICD-Loader.git'
  git_hashtag "v#{@_ver}"

  depends_on 'opencl_headers' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env #{CREW_ENV_OPTIONS} \
        cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DOPENCL_HEADERS_INSTALL_DIR=#{CREW_PREFIX} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
