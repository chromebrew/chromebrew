require 'package'

class Libcss < Package
  description 'CSS parser and selection engine, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.9.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libcss-0.9.1-src.tar.gz'
  source_sha256 'd2dce16e93392e8d6a7209420d47c2d56a3811701a0e81a724fc541c63d3c6dc'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcss/0.9.1_armv7l/libcss-0.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcss/0.9.1_armv7l/libcss-0.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcss/0.9.1_i686/libcss-0.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcss/0.9.1_x86_64/libcss-0.9.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f34982b8995086556d75aa49105afdc8478f204a32c4ec01d53d4696b1419916',
     armv7l: 'f34982b8995086556d75aa49105afdc8478f204a32c4ec01d53d4696b1419916',
       i686: '8b75584cdc3db5d1a6a78653ca8926f7108a1dc19f053675a89cf2d174662aa1',
     x86_64: '8de9cd9715f8089a787b3bd757161690d13b409badb503875d1b069815b80d3c'
  })

  depends_on 'netsurf_buildsystem' => :build
  depends_on 'libparserutils'
  depends_on 'libwapcaplet'

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
