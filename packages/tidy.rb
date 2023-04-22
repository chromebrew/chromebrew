require 'package'

class Tidy < Package
  description 'The granddaddy of HTML tools, with support for modern standards'
  homepage 'http://www.html-tidy.org/'
  version '5.8.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htacg/tidy-html5/archive/5.8.0.tar.gz'
  source_sha256 '59c86d5b2e452f63c5cdb29c866a12a4c55b1741d7025cf2f3ce0cde99b0660e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0_armv7l/tidy-5.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0_armv7l/tidy-5.8.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0_i686/tidy-5.8.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0_x86_64/tidy-5.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3865806933d4fb0d2a72777f4f3f498a44e02b7fde5d3a67900d0d9497e080b5',
     armv7l: '3865806933d4fb0d2a72777f4f3f498a44e02b7fde5d3a67900d0d9497e080b5',
       i686: '1b8c20aa52b283b5a51e1c17fe29edbe785378958b10192a67289eb5b96726b2',
     x86_64: 'd9830bb0e92f4f1d8cf8412b44a40697551f3b50ab76997fd1681b170ac00ae3'
  })

  def self.build
    system "cmake -B build/cmake \
      #{CREW_CMAKE_OPTIONS} \
      -DLIB_SUFFIX=#{CREW_LIB_SUFFIX} \
      -DBUILD_TAB2SPACE=ON"
    system 'make -C build/cmake'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make -C build/cmake install"
  end
end
