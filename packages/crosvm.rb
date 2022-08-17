# Adapted from Arch Linux crosvm-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=crosvm-git

require 'package'

class Crosvm < Package
  description 'The Chrome OS Virtual Machine Monitor'
  homepage 'https://chromium.googlesource.com/crosvm/crosvm'
  version '7b5f6b1'
  license 'custom:chromiumos'
  compatibility 'x86_64'
  source_url 'https://chromium.googlesource.com/crosvm/crosvm.git'
  git_hashtag '7b5f6b198fa2e3acc797175670fad8686db3e72e'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crosvm/7b5f6b1_x86_64/crosvm-7b5f6b1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '6c33130dd77e022f159e537ce7795a67100fc6edf6e4ac2956de593f0ebec201'
  })

  depends_on 'libcap'
  depends_on 'dtc'
  depends_on 'protobuf'
  depends_on 'rust' => :build
  depends_on 'wayland_protocols' => :build

  def self.build
    @pwd = `pwd`.chomp
    FileUtils.mkdir 'build_bin'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/gcc", 'build_bin/arm-linux-gnueabihf-gcc' if ARCH == 'armv7l'
    system "PATH=#{@pwd}/build_bin:$PATH cargo build --release"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install 'target/release/crosvm', "#{CREW_DEST_PREFIX}/bin/crosvm", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/policy/crosvm/"
    FileUtils.cp_r Dir.glob("seccomp/#{ARCH}/*"), "#{CREW_DEST_PREFIX}/share/policy/crosvm/" if ARCH == 'x86_64'
  end
end
