require 'package'

class Fuse3 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  @_ver = '3.10.4'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://github.com/libfuse/libfuse.git"
  git_hashtag 'fuse-' + @_ver

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
