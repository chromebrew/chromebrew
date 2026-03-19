require 'buildsystems/meson'

class Fuse3 < Meson
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse/'
  version '3.18.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libfuse/libfuse.git'
  git_hashtag "fuse-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f34226f5c0e59011579ea20b805ddd718184c2e7f25cfb8993712b9ec7282b72',
     armv7l: 'f34226f5c0e59011579ea20b805ddd718184c2e7f25cfb8993712b9ec7282b72',
       i686: '568a592a431b5a61bd311d23d0d8116166b7e2a48020c18070eafe97256b90aa',
     x86_64: '89edc4152da90ea28da4f44dafa939cf8925bff378e8597d7be41fe2049393d3'
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
