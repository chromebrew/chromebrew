require 'buildsystems/rust'

class Zed < RUST
  description 'Zed is a high-performance, multiplayer code editor'
  homepage 'https://zed.dev/'
  version '0.196.6'
  license 'GPL-3, AGPL-3, Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/zed-industries/zed.git'
  git_hashtag "v#{version}"

  binary_sha256({
     x86_64: '86630d24169d03f328a1d7b10096010713ed3a5bd101f9556347670eab0b9333'
  })

  depends_on 'alsa_lib'
  depends_on 'cargo_about' => :build
  depends_on 'libbsd'
  depends_on 'libxau'
  depends_on 'libxcb'
  depends_on 'libxdmcp'
  depends_on 'libxkbcommon'
  depends_on 'llvm_dev' => :build
  depends_on 'openssl'
  depends_on 'ruby_solargraph' # L
  depends_on 'rust' => :build
  depends_on 'zlib'
  depends_on 'zstd'

  rust_flags "-C link-args=-Wl,--disable-new-dtags,-rpath,\$ORIGIN/../#{ARCH_LIB} -C symbol-mangling-version=v0 --cfg tokio_unstable -C link-arg=-fuse-ld=mold"
  rust_install_path 'crates/zed crates/cli'
  # rust_packages 'zed cli'

  def self.prebuild
    system 'script/generate-licenses'
  end

  def self.postinstall
    ExitMessage.add "\nType 'zed' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/zed")
  end
end
