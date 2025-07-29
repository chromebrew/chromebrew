require 'buildsystems/rust'

class Zed < RUST
  description 'Zed is a high-performance, multiplayer code editor'
  homepage 'https://zed.dev/'
  version '0.196.6'
  license 'GPL-3, AGPL-3, Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/zed-industries/zed.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '8320adf4460453f9e1d2baa2f7acf9326d4f0a8d011c223715dcfd1424957c76'
  })

  depends_on 'alsa_lib' # R
  depends_on 'cargo_about' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxkbcommon' # R
  depends_on 'llvm_dev' => :build
  depends_on 'openssl' # R
  depends_on 'ruby_solargraph' # L
  depends_on 'rust' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  rust_flags '-C link-args=-Wl,--disable-new-dtags,-rpath,$ORIGIN/../lib -C symbol-mangling-version=v0 --cfg tokio_unstable'
  rust_packages 'zed'

  def self.prebuild
    system 'script/generate-licenses'
  end

  def self.install
    system "DO_STARTUP_NOTIFY=true APP_CLI=zed APP_ICON=zed \
      APP_ARGS='%U' APP_NAME=Zed \
      envsubst < 'crates/zed/resources/zed.desktop.in' > zed.desktop"
    FileUtils.install 'target/release/zed', "#{CREW_DEST_PREFIX}/bin/zed", mode: 0o755
    FileUtils.install 'zed.desktop', "#{CREW_DEST_PREFIX}/share/applications/zed.desktop", mode: 0o644
    FileUtils.install 'crates/zed/resources/app-icon.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/512x512/apps/zed.png", mode: 0o644
    FileUtils.install 'crates/zed/resources/app-icon@2x.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/1024x1024/apps/zed.png", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'zed' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/zed")
  end
end
