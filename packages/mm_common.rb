require 'package'

class Mm_common < Package
  description 'Common build files of the C++ bindings'
  homepage 'http://www.gtkmm.org/'
  version '1.0.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/mm-common.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.5_armv7l/mm_common-1.0.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.5_armv7l/mm_common-1.0.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.5_i686/mm_common-1.0.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mm_common/1.0.5_x86_64/mm_common-1.0.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a110f805f19bc44dbd355baed6cbb85291bfaafd6dd7a0e2e42c6abde4aa8d0e',
     armv7l: 'a110f805f19bc44dbd355baed6cbb85291bfaafd6dd7a0e2e42c6abde4aa8d0e',
       i686: '5d10a96b65a810fd6d3fb8d686307b15bea5dc54e7e30d5f3983ad0225493ca6',
     x86_64: '33eed58c4c387e25ee5d70a9b0c64525db105553918b03819a7ed27959c11553'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Duse-network=true \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
