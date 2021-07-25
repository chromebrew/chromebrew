require 'package'

class Squashfs < Package
  description 'Squashfs is a compressed read-only filesystem for Linux.'
  homepage 'http://squashfs.sourceforge.net/'
  version '4.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.5/squashfs4.5.tar.gz'
  source_sha256 'c493b29c3d152789d04fae5e6532499d96ce3f79256bc6df4f97b5170c88e979'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.5_armv7l/squashfs-4.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.5_armv7l/squashfs-4.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.5_i686/squashfs-4.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/squashfs/4.5_x86_64/squashfs-4.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '630e363cf16b40b181ac3e09792ae9d7f73874ea4e902905824785c7c489546d',
     armv7l: '630e363cf16b40b181ac3e09792ae9d7f73874ea4e902905824785c7c489546d',
       i686: 'b72fc434de5a0c0f80edadff18efb2dfc13bc3223fe7a57b366621c1b34572f4',
     x86_64: '6a3f77adbef01926ed731f7a69dab7607218dd13b31dda230556d5590dd7eea3'
  })

  depends_on 'compressdoc' => :build
  depends_on 'help2man' => :build
  depends_on 'lzo'

  def self.build
    FileUtils.cd('squashfs-tools') do
      system "sed -i '5iLZ4_SUPPORT = 1' Makefile"
      system "sed -i '6iLZO_SUPPORT = 1' Makefile"
      system "sed -i '7iXZ_SUPPORT = 1' Makefile"
      system 'make'
    end
  end

  def self.install
    FileUtils.cd('squashfs-tools') do
      system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man1"
      system "install -Dm755 mksquashfs #{CREW_DEST_PREFIX}/bin/mksquashfs"
      system "install -Dm755 unsquashfs #{CREW_DEST_PREFIX}/bin/unsquashfs"
      system "help2man ./mksquashfs -N --no-discard-stderr > #{CREW_DEST_PREFIX}/share/man/man1/mksquashfs.1"
      system "help2man ./unsquashfs -N --no-discard-stderr > #{CREW_DEST_PREFIX}/share/man/man1/unsquashfs.1"
    end
  end
end
