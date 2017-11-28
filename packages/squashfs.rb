require 'package'

class Squashfs < Package
  description 'Squashfs is a compressed read-only filesystem for Linux.'
  homepage 'http://squashfs.sourceforge.net/'
  version '4.3'
  source_url 'https://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.3/squashfs4.3.tar.gz'
  source_sha256 '0d605512437b1eb800b4736791559295ee5f60177e102e4d4ccd0ee241a5f3f6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'compressdoc' => :build
  depends_on 'help2man' => :build
  depends_on 'lz4'
  depends_on 'lzo'
  depends_on 'xzutils'
  depends_on 'zlibpkg'

  def self.build
    FileUtils.cd('squashfs-tools') do
      system "sed -i '5iLZ4_SUPPORT = 1' Makefile"
      system "sed -i '6iLZO_SUPPORT = 1' Makefile"
      system "sed -i '7iXZ_SUPPORT = 1' Makefile"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('squashfs-tools') do
      system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man1"
      system "install -Dm755 mksquashfs #{CREW_DEST_PREFIX}/bin/mksquashfs"
      system "install -Dm755 unsquashfs #{CREW_DEST_PREFIX}/bin/unsquashfs"
      system "help2man ./mksquashfs -N --no-discard-stderr > #{CREW_DEST_PREFIX}/share/man/man1/mksquashfs.1"
      system "help2man ./unsquashfs -N --no-discard-stderr > #{CREW_DEST_PREFIX}/share/man/man1/unsquashfs.1"
      system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    end
  end
end
