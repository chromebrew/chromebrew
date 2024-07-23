require 'buildsystems/meson'

class Fuse3 < Meson
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  version '3.16.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7596282fa27cbe6683c81cb3158159421b3a21834db71f4130fbea2d7d8ca59a',
     armv7l: '7596282fa27cbe6683c81cb3158159421b3a21834db71f4130fbea2d7d8ca59a',
       i686: 'b6197530830442cb1225334e9fa29d00a113ded9a4ff7e072c335e91e468244e',
     x86_64: '14b191a1e6b19c58f9e45861fae0be8b50a10803dab46b98ac82a3c6f906c60b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
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
