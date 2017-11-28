require 'package'

class Cgroupfs_mount < Package
  description 'Simple scripts to properly mount the cgroupfs hierarchy.'
  homepage 'https://github.com/tianon/cgroupfs-mount'
  version '1.4'
  source_url 'https://github.com/tianon/cgroupfs-mount/archive/1.4.tar.gz'
  source_sha256 'd6c8aff7af59c7d0082ee3018c97f73b0421e81a49bb28ad9f66a36da5cd6ec7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'compressdoc' => :build

  def self.install
    system "install -Dm755 cgroupfs-mount #{CREW_DEST_PREFIX}/bin/cgroupfs-mount"
    system "install -Dm755 cgroupfs-umount #{CREW_DEST_PREFIX}/bin/cgroupfs-umount"
    system "install -Dm644 cgroupfs-mount.8 #{CREW_DEST_PREFIX}/share/man/man8/cgroupfs-mount.8"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
