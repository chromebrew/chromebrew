require 'package'

class Fuse3 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  version '3.10.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://github.com/libfuse/libfuse/releases/download/fuse-#{version}/fuse-#{version}.tar.xz"
  source_sha256 '736e8d1ce65c09cb435fbbb500d53dc75f4d6e93bd325d22adc890951cf56337'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.2_armv7l/fuse3-3.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.2_armv7l/fuse3-3.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.2_i686/fuse3-3.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.2_x86_64/fuse3-3.10.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6e4d623810017d9dc58852f19d251fe52282578d6099ea41eac94d23eb0066e8',
     armv7l: '6e4d623810017d9dc58852f19d251fe52282578d6099ea41eac94d23eb0066e8',
       i686: 'd202035312895ee3bd9d260775cabba729d67996b3a3c1ce3786c83120515efa',
     x86_64: 'c82701ac8f799f7716963363ab44b8a7984d580eff3ecd1d54ddbc589e08c907'
  })

  def self.build
    system "pip install --upgrade --no-warn-script-location pytest --prefix #{CREW_PREFIX}"
    system "meson #{CREW_MESON_OPTIONS} \
    -Ddisable-mtab=true \
    -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d/ \
    -Dexamples=true \
    -Duseroot=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/init.d/"
    FileUtils.mv "#{CREW_DEST_DIR}/etc/init.d/fuse3", "#{CREW_DEST_PREFIX}/etc/init.d/fuse3"
    FileUtils.mv "#{CREW_DEST_PREFIX}/sbin/mount.fuse3", "#{CREW_DEST_PREFIX}/bin/mount.fuse3"
    system 'pip uninstall -y pytest'
  end
end
