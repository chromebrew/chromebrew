require 'package'

class Vmaf < Package
  description 'Perceptual video quality assessment algorithm based on multi-method fusion'
  homepage 'https://github.com/Netflix/vmaf/'
  @_ver = '2.1.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/Netflix/vmaf/archive/v#{@_ver}.tar.gz"
  source_sha256 'e7fc00ae1322a7eccfcf6d4f1cdf9c67eec8058709887c8c6c3795c617326f77'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vmaf-2.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vmaf-2.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vmaf-2.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vmaf-2.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fd05f6c2ad4d9f6373d8136db11f858169c17e6c2937a1bcedf381e93408c6e2',
     armv7l: 'fd05f6c2ad4d9f6373d8136db11f858169c17e6c2937a1bcedf381e93408c6e2',
       i686: '2163726aef956a8267845bba4b139c693481030531a4d12d120230fdb4e40c12',
     x86_64: '1453af3bc71ee46c7aef48dc8d402440d08a76518a4761fb185347694a8095d1'
  })

  depends_on 'nasm' => ':build'

  def self.build
    @avx512 = ARCH == 'x86_64' ? 'true' : 'false'

    Dir.chdir 'libvmaf' do
      system "meson #{CREW_MESON_LTO_OPTIONS} \
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
