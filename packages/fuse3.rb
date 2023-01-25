require 'package'

class Fuse3 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  @_ver = '3.12.0'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.12.0_armv7l/fuse3-3.12.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.12.0_armv7l/fuse3-3.12.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.12.0_i686/fuse3-3.12.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fuse3/3.12.0_x86_64/fuse3-3.12.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '993575dfb3dd1bd71bdab177b810042b8923750cc5c4453dfedfc985e8d9d7fe',
     armv7l: '993575dfb3dd1bd71bdab177b810042b8923750cc5c4453dfedfc985e8d9d7fe',
       i686: '3ede85f339d0730975f3e9a5cec0aecb562ce9886d621d348e13e02f2704fb70',
     x86_64: '6f554e2c2576556e4dcfe6cb45b6c1416a972d88923a435f8d7528501b2df988'
  })

  depends_on 'py3_pytest' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R

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
