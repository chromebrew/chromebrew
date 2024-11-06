require 'package'

class Cgroupfs_mount < Package
  description 'Simple scripts to properly mount the cgroupfs hierarchy.'
  homepage 'https://github.com/tianon/cgroupfs-mount'
  version '1.4'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/tianon/cgroupfs-mount/archive/1.4.tar.gz'
  source_sha256 'd6c8aff7af59c7d0082ee3018c97f73b0421e81a49bb28ad9f66a36da5cd6ec7'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '5291e3cba179034a52b508008b0b35fcb5d8a800a8e14068ade8d2c1feda8ee1',
     armv7l: '5291e3cba179034a52b508008b0b35fcb5d8a800a8e14068ade8d2c1feda8ee1',
       i686: '17411a50bef5f297e558686e86f3ee710b744fa3b78458fbaa9d90219bfa0df8',
     x86_64: 'd01398e7d06e023f625bb36d5c80d20b25bd0db9d0d71d08bfa9e12c8cc36a2a'
  })

  depends_on 'compressdoc' => :build

  def self.install
    system "install -Dm755 cgroupfs-mount #{CREW_DEST_PREFIX}/bin/cgroupfs-mount"
    system "install -Dm755 cgroupfs-umount #{CREW_DEST_PREFIX}/bin/cgroupfs-umount"
    system "install -Dm644 cgroupfs-mount.8 #{CREW_DEST_PREFIX}/share/man/man8/cgroupfs-mount.8"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
