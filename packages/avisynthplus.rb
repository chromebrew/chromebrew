require 'package'

class Avisynthplus < Package
  description 'An improved version of the AviSynth frameserver'
  homepage 'https://avs-plus.net/'
  version '3.7.2'
  license 'GPL-2 and GPL-2-with-linking-exception'
  compatibility 'all'
  source_url 'https://github.com/AviSynth/AviSynthPlus/archive/v3.7.2/avisynthplus-3.7.2.tar.gz'
  source_sha256 '6159fd976dffa62d5db5277cbb0b3b7f7a4ee92fc8667edd32da9840a669ccc1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avisynthplus/3.7.2_armv7l/avisynthplus-3.7.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avisynthplus/3.7.2_armv7l/avisynthplus-3.7.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avisynthplus/3.7.2_i686/avisynthplus-3.7.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avisynthplus/3.7.2_x86_64/avisynthplus-3.7.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '33a07e40e5de09d4b6a3c932c3a7c05d9e809bf388950ed69d2127d24a7d5ac5',
     armv7l: '33a07e40e5de09d4b6a3c932c3a7c05d9e809bf388950ed69d2127d24a7d5ac5',
       i686: 'e97386b6df6772e0e495f29260091fac407cb50203ae9b0e41ecf9e94458a047',
     x86_64: '122650ad7a858af46806c779da6e045c43bc267a004b2de255b947def1d4cff5'
  })

  depends_on 'devil' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
