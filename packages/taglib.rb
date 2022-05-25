require 'package'

class Taglib < Package
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '1.13.1'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://taglib.org/releases/taglib-1.13.1.tar.gz'
  source_sha256 'c8da2b10f1bfec2cd7dbfcd33f4a2338db0765d851a50583d410bacf055cfd0b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13.1_armv7l/taglib-1.13.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13.1_armv7l/taglib-1.13.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13.1_i686/taglib-1.13.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13.1_x86_64/taglib-1.13.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dcfa97bc61b0aa4878a96cfa82177614bc9bc1095cadf265f9065ba43a3e1f64',
     armv7l: 'dcfa97bc61b0aa4878a96cfa82177614bc9bc1095cadf265f9065ba43a3e1f64',
       i686: '474adc96ebfec82a8a458f871520c1efbc6c9e6b6ccb2285ea59fe76cd1bdacd',
     x86_64: '07297b6925fd56cf8623cc4af997d5dbe548628d1330fd94494eed422d4e4a65'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja"
    system "#{CREW_NINJA} -C builddir || ( sed -i 's/-fno-lto//g' builddir/taglib/build.ninja && #{CREW_NINJA} -C builddir)"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
