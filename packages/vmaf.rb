require 'package'

class Vmaf < Package
  description 'Perceptual video quality assessment algorithm based on multi-method fusion'
  homepage 'https://github.com/Netflix/vmaf/'
  version '3.0.0'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/Netflix/vmaf/archive/v#{version}.tar.gz"
  source_sha256 '7178c4833639e6b989ecae73131d02f70735fdb3fc2c7d84bc36c9c3461d93b1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27223f17a875ef85c4d64bffe55f2e755b6657a51a64918a080722799fd34261',
     armv7l: '27223f17a875ef85c4d64bffe55f2e755b6657a51a64918a080722799fd34261',
       i686: '9f180b6295edecf76ce72fcd331693f833a8bc55d70dd6aec9c87563863b471e',
     x86_64: '5379016438e0aaa04fc4da41673b583ae7b846adf360f71bbce318a67271984b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build

  def self.build
    @avx512 = ARCH == 'x86_64' ? 'true' : 'false'

    Dir.chdir 'libvmaf' do
      system "meson setup #{CREW_MESON_OPTIONS} \
      -Denable_docs=false \
      -Denable_tests=false \
      -Denable_avx512=#{@avx512} \
      -Denable_float=true \
      builddir"
    end
    system 'meson configure libvmaf/builddir'
    system 'ninja -C libvmaf/builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C libvmaf/builddir install"
  end
end
