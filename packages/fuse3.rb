require 'package'

class Fuse3 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  version '3.14.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f4b9c7ae2b8f94e0e9e745beb28d44ab2eacc0780eafb39f5bbfc6698498736',
     armv7l: '5f4b9c7ae2b8f94e0e9e745beb28d44ab2eacc0780eafb39f5bbfc6698498736',
       i686: '7a123c98ec3ca9d47692119ed47aa573ebc10e553edfac86f38e258357bd2d7b',
     x86_64: '342b9a27abb38fff56ddc6f99635849d1eba12ff241ad8514125a418f470b61b'
  })

  depends_on 'py3_pytest' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddisable-mtab=true \
      -Dudevrulesdir=#{CREW_PREFIX}/etc/udev/rules.d/ \
      -Dexamples=true \
      -Duseroot=false \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

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
