require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.42'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz'
  source_sha256 'c33b418e3b936ee3153de2c61cc638e7e4fe3156022a5c77d0711bcbb9d64f1f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.42_armv7l/pcre2-10.42-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.42_armv7l/pcre2-10.42-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.42_i686/pcre2-10.42-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre2/10.42_x86_64/pcre2-10.42-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '880eb9d98a13f8532d61d6d414890ab3a5f40f3249d23f85ed097bc9d4650deb',
     armv7l: '880eb9d98a13f8532d61d6d414890ab3a5f40f3249d23f85ed097bc9d4650deb',
       i686: 'f8347980ff02d8fe3788a1fa7910beb5b012f25a2ecbbb8f28fca85d19c28cd0',
     x86_64: 'a25406089eec4ef61249c02927b2af2f20602eee7389409739041d5c777942f4'
  })

  depends_on 'glibc' # R
  depends_on 'readline' # R
  depends_on 'bzip2' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "cmake -B builddir\
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DPCRE2_BUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DPCRE2_SUPPORT_JIT=ON \
      -DPCRE2_STATIC_PIC=ON \
      -DPCRE2_BUILD_PCRE2_16=ON \
      -DPCRE2_BUILD_PCRE2_32=ON \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/cmake/pcre2"
    FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/man/*"), "#{CREW_DEST_MAN_PREFIX}/"
    FileUtils.rmdir "#{CREW_DEST_PREFIX}/man"
    FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/cmake/*"), "#{CREW_DEST_LIB_PREFIX}/cmake/pcre2/"
    FileUtils.rmdir "#{CREW_DEST_PREFIX}/cmake"
  end
end
