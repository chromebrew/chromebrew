require 'package'

class Opencl_headers < Package
  description 'OpenCL header files'
  homepage 'https://github.com/KhronosGroup/OpenCL-Headers'
  version '2022.09.30'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68ea6d940a1d947e20f199406ba7ba9ff3bcbfe339a909d05eb1e2ec3b1a7f52',
     armv7l: '68ea6d940a1d947e20f199406ba7ba9ff3bcbfe339a909d05eb1e2ec3b1a7f52',
       i686: '78c61aef623259ba152518900461ee23cdad15dfa18b8f18ba7602477786f88d',
     x86_64: '5a930f083f71b83e79eb14fd90ea5e0df880e5d2227a8cfc781e66c4b5862edc'
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
