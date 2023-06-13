# Adapted from Arch Linux crosvm-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=crosvm-git

require 'package'

class Crosvm < Package
  description 'The Chrome OS Virtual Machine Monitor'
  homepage 'https://chromium.googlesource.com/crosvm/crosvm'
  version '379dd2d'
  license 'custom:chromiumos'
  compatibility 'x86_64'
  source_url 'https://chromium.googlesource.com/crosvm/crosvm.git'
  git_hashtag '379dd2dfecf1a0c06adf0f6e257a5ebc75374cb8'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crosvm/379dd2d_x86_64/crosvm-379dd2d-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '0292c2ccfc2261c756aeb82e48a6cac14efdf4fff2483950eacc05cd040451d4'
  })

  depends_on 'libcap'
  depends_on 'dbus'
  depends_on 'dtc'
  depends_on 'protobuf'
  depends_on 'rust' => :build
  depends_on 'virglrenderer'
  depends_on 'wayland_protocols' => :build

  def self.build
    @pwd = Dir.pwd
    FileUtils.mkdir 'build_bin'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc", 'build_bin/arm-linux-gnueabihf-gcc' if (ARCH == 'aarch64') || (ARCH == 'armv7l')
    system "PATH=#{@pwd}/build_bin:$PATH cargo build --release --features=virgl_renderer"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install 'target/release/crosvm', "#{CREW_DEST_PREFIX}/bin/crosvm", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/policy/crosvm/"
    FileUtils.cp_r "seccomp/#{ARCH}/*", "#{CREW_DEST_PREFIX}/share/policy/crosvm/" if ARCH == 'x86_64'
  end
end
