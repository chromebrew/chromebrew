require 'package'

class Fuse < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  version '3.10.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://github.com/libfuse/libfuse/releases/download/fuse-#{version}/fuse-#{version}.tar.xz"
  source_sha256 '736e8d1ce65c09cb435fbbb500d53dc75f4d6e93bd325d22adc890951cf56337'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-3.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-3.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-3.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-3.10.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2f869838f88e0a8df6ef38b84b1b2c379ec2b14d0c7c95cdd7a2f759d5042e42',
     armv7l: '2f869838f88e0a8df6ef38b84b1b2c379ec2b14d0c7c95cdd7a2f759d5042e42',
       i686: 'fa4568332e5646bca84fbd3364bd9055f4acfbc12f47caf93bbbbc071bc6382f',
     x86_64: '56c922765b937e931b86a7589dc0b08be52263c45078a42757c43ae6a5081865'
  })

  def self.build
    system "pip install --upgrade --no-warn-script-location pytest --prefix #{CREW_PREFIX}"
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
