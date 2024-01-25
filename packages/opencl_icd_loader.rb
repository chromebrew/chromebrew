require 'package'

class Opencl_icd_loader < Package
  description 'OpenCL Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/OpenCL-ICD-Loader'
  version '2022.09.30'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-ICD-Loader.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e49bb8bb67b4ab19e42f334c219c494fd05e30340df862750515017194df05e8',
     armv7l: 'e49bb8bb67b4ab19e42f334c219c494fd05e30340df862750515017194df05e8',
       i686: 'b819bce928df90fb1101337985a0c48c31c4f2e94420c8393dc2f6eaaf398b63',
     x86_64: '609de7c8d6bc96f75c3c455b2172ba57f4afd7620bfee34703f9806d840865e3'
  })

  depends_on 'glibc' # R
  depends_on 'opencl_headers' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DOPENCL_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DOPENCL_ICD_LOADER_BUILD_TESTING=ON \
         .."
    end
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
