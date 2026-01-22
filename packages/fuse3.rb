require 'buildsystems/meson'

class Fuse3 < Meson
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  version '3.18.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a07a40a56054303557bac6c18a4d500eb2779900bdb34183fd9fa122f644a675',
     armv7l: 'a07a40a56054303557bac6c18a4d500eb2779900bdb34183fd9fa122f644a675',
       i686: '27ee11c7cca4f8e7336d8d88bffe6066472b9de3223ecc0c600a854f0a821d35',
     x86_64: 'f2215c568cf0b7f378ee63d7b558ee409abfe974a54aa271f270cf2542d5119b'
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
