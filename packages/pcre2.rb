# frozen_string_literal: true

require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  @_ver = '10.40'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.40/pcre2-10.40.tar.gz'
  source_sha256 'ded42661cab30ada2e72ebff9e725e745b4b16ce831993635136f2ef86177724'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.40_armv7l/pcre2-10.40-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.40_armv7l/pcre2-10.40-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.40_i686/pcre2-10.40-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.40_x86_64/pcre2-10.40-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e81850b864c3af34d3ebf7a24620d3c9c612a89fc75a92f2191d83aad80ec487',
     armv7l: 'e81850b864c3af34d3ebf7a24620d3c9c612a89fc75a92f2191d83aad80ec487',
       i686: 'e8416aebe3c3b14b1523a3a1b57a5bf947e700517714ab96db406edc0c1af0dd',
     x86_64: '1e09d4a30ca30ad9f4103d6fe5ba865cf87a0be83c97f3e8d4e0a543736f7b6c'
  })

  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'bz2' # R
  depends_on 'zlibpkg' # R

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "env cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DPCRE2_BUILD_TESTS=OFF \
        -DBUILD_SHARED_LIBS=ON \
        -DPCRE2_SUPPORT_JIT=ON \
        -DPCRE2_STATIC_PIC=ON \
        -DPCRE2_BUILD_PCRE2_16=ON \
        -DPCRE2_BUILD_PCRE2_32=ON \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/cmake/pcre2"
    FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/man/*"), "#{CREW_DEST_MAN_PREFIX}/"
    FileUtils.rmdir "#{CREW_DEST_PREFIX}/man"
    FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/cmake/*"), "#{CREW_DEST_LIB_PREFIX}/cmake/pcre2/"
    FileUtils.rmdir "#{CREW_DEST_PREFIX}/cmake"
  end
end
