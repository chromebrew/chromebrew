require 'package'

class Tidy < Package
  description 'The granddaddy of HTML tools, with support for modern standards'
  homepage 'http://www.html-tidy.org/'
  version '5.8.0-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htacg/tidy-html5/archive/5.8.0.tar.gz'
  source_sha256 '59c86d5b2e452f63c5cdb29c866a12a4c55b1741d7025cf2f3ce0cde99b0660e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0-1_armv7l/tidy-5.8.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0-1_armv7l/tidy-5.8.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0-1_i686/tidy-5.8.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tidy/5.8.0-1_x86_64/tidy-5.8.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '968686c5c89e00f8fdb99f5840430bd028360726404558b0686ac4e018f2a00d',
     armv7l: '968686c5c89e00f8fdb99f5840430bd028360726404558b0686ac4e018f2a00d',
       i686: '911e08b1a7e63ca787429839ace0c6e573e6ef60ce248e66c093da0911c2a9f4',
     x86_64: '59f1d096f5c745ae606f37e136aac3aa4b0ae4337efa4ee7415ffed9f946d0ff'
  })

  depends_on 'glibc' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_LIBSUFFIX_OPTIONS} \
      -DBUILD_TAB2SPACE=ON \
      -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
