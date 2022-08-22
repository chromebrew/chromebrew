require 'package'

class Numactl < Package
  description 'NUMA support for Linux'
  homepage 'https://github.com/numactl/numactl'
  version '2.0.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/numactl/numactl/releases/download/v2.0.13/numactl-2.0.13.tar.gz'
  source_sha256 '991e254b867eb5951a44d2ae0bf1996a8ef0209e026911ef6c3ef4caf6f58c9a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.13_armv7l/numactl-2.0.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.13_armv7l/numactl-2.0.13-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.13_i686/numactl-2.0.13-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/numactl/2.0.13_x86_64/numactl-2.0.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1b1e55bb8d1b72d460bd7877845e86a27a449671a0e6987bd2ba97714f8151b4',
     armv7l: '1b1e55bb8d1b72d460bd7877845e86a27a449671a0e6987bd2ba97714f8151b4',
       i686: '461961c1da4c70d5ae773a4a0c55b8b73bcf89ba61d305396843e22faead4a43',
     x86_64: '806ddeb8af5525f77f826e366517990270668625ef77910deb6ebe8494d22676'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
