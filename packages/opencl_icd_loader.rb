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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_icd_loader/2022.01.04_armv7l/opencl_icd_loader-2022.01.04-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_icd_loader/2022.01.04_armv7l/opencl_icd_loader-2022.01.04-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_icd_loader/2022.01.04_i686/opencl_icd_loader-2022.01.04-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opencl_icd_loader/2022.01.04_x86_64/opencl_icd_loader-2022.01.04-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '060686f444eb9a9484b305d05eeb919fb20460c724eaecc6997ca0fe5158ded1',
     armv7l: '060686f444eb9a9484b305d05eeb919fb20460c724eaecc6997ca0fe5158ded1',
       i686: '53e3402e0df4c65cb9d6169ffbd96508888b1419d6626ea648f8e7e292dd70a0',
     x86_64: 'e2d9de8e96da760c71576e88a0af5132b052abf070b8c698aac6e2e2fe5929b9'
  })

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
