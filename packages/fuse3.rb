require 'package'

class Fuse3 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  @_ver = '3.10.5'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.5_armv7l/fuse3-3.10.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.5_armv7l/fuse3-3.10.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.5_i686/fuse3-3.10.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.5_x86_64/fuse3-3.10.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd14bba8e1c8af4cdebbf02f4be6ee860c7351c2ceb0a53a67606d26dfb76f3bc',
     armv7l: 'd14bba8e1c8af4cdebbf02f4be6ee860c7351c2ceb0a53a67606d26dfb76f3bc',
       i686: 'd0ec9909aa08547edc2371507e4c371ff9df9ba18330ba70ada4fd11979dd5ef',
     x86_64: '95849855fa8d643efb20145cc25d4752ef10376d6656fda2d7f755bc5ac6977b'
  })

  depends_on 'py3_pytest' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Ddisable-mtab=true \
    -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d/ \
    -Dexamples=true \
    -Duseroot=false \
    builddir"
    system 'meson configure builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/init.d/"
    FileUtils.mv "#{CREW_DEST_DIR}/etc/init.d/fuse3", "#{CREW_DEST_PREFIX}/etc/init.d/fuse3"
  end
end
