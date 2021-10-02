require 'package'

class Fuse3 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  @_ver = '3.10.4'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{@_ver}"

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.2_i686/fuse3-3.10.2-chromeos-i686.tar.xz',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.4_armv7l/fuse3-3.10.4-chromeos-armv7l.tpxz',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.4_armv7l/fuse3-3.10.4-chromeos-armv7l.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.10.4_x86_64/fuse3-3.10.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: 'd202035312895ee3bd9d260775cabba729d67996b3a3c1ce3786c83120515efa',
 aarch64: 'a2bdd79da18341278a512a50406faa3fdb8bd400a508706fe5c8a9fdacf1ffb5',
  armv7l: 'a2bdd79da18341278a512a50406faa3fdb8bd400a508706fe5c8a9fdacf1ffb5',
  x86_64: '1930e0a48097c5e85a4f8b82acfa1e55c579d20677d5cdf6731dcca745bf6556'
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
