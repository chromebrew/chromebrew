require 'buildsystems/meson'

class Fuse3 < Meson
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  version '3.18.3'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b706ff61a5fb900608b219625c5e5408c39090c3d77e42b3c9347db451a3a2a1',
     armv7l: 'b706ff61a5fb900608b219625c5e5408c39090c3d77e42b3c9347db451a3a2a1',
       i686: '5a2cb1837e8d978f944778c5189a14bb908ff4a93d00693e43ad579bd7e14458',
     x86_64: '9f94e58d5c4462d0246f10ddcd07786c1b76ec604e45b298e3d129c7581d03fa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'py3_pytest' => :build

  meson_options "-Ddisable-mtab=true \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d/ \
      -Dexamples=true \
      -Duseroot=false"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/sbin"
    Dir.chdir "#{CREW_DEST_PREFIX}/sbin" do
      FileUtils.ln_s '../bin/fusermount3', 'fusermount3'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/init.d/"
    FileUtils.mv "#{CREW_DEST_DIR}/etc/init.d/fuse3", "#{CREW_DEST_PREFIX}/etc/init.d/fuse3"
  end

  def self.postinstall
    system "sudo chown root:root #{CREW_PREFIX}/bin/fusermount3"
    system "sudo chmod 4755 #{CREW_PREFIX}/bin/fusermount3"
  end
end
