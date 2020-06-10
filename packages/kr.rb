require 'package'

class Kr < Package
  description 'Krypton command-line client, daemon, and SSH integration'
  homepage 'https://krypt.co'
  version '2.4.4'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/kryptco/kr/master/README.md'
  source_sha256 'a0452783d22218a6fab914abbf5263459aaa1c8745512d7c4ebcf51fe08aaf7a'

  depends_on "rust" => :build
  depends_on "go" => :build
  depends_on "libsodium" => :build
  depends_on "rsync" => :build
  depends_on "psmisc" => :build

  def self.install
    cargo_web_version = "0.6.10"
    cargo_web_sha256 = "c8a92ed0185206ad7f2da8e1692d168b20044de7066b2eb086e4bbb0d06ff787"
    ENV["GOPATH"] = "#{Dir.pwd}/go"
    ENV["RUSTUP_HOME"] = "#{Dir.pwd}/.rustup"
    ENV["CARGO_HOME"] = "#{Dir.pwd}/.cargo"
    system "mkdir -p #{ENV["RUSTUP_HOME"]}"
    system "mkdir -p #{ENV["CARGO_HOME"]}"

    system "rustup", "install", "stable"
    system "rustup", "default", "stable"
    system "rustup", "target", "add", "wasm32-unknown-emscripten"

    system "curl -Ls https://github.com/koute/cargo-web/archive/#{cargo_web_version}.zip -o cargo-web.zip"
    abort "Checksum mismatch. :/  Try again.".lightred unless Digest::SHA256.hexdigest( File.read("cargo-web.zip") ) == "#{cargo_web_sha256}"
    system "unzip cargo-web.zip"
    FileUtils.cd("cargo-web-#{cargo_web_version}") do
      system "cargo build --release && cargo install"
    end

    system "mkdir -p #{Dir.pwd}/go/src"
    system "go get github.com/kryptco/kr"
    FileUtils.cd("go/src/github.com/kryptco/kr") do
      ENV["PREFIX"] = "#{CREW_PREFIX}"
      ENV["PWD"] = Dir.pwd
      system "git checkout tags/2.4.4"
      system "git submodule update --init --recursive"
      system "git checkout -- Makefile"
      system "sed -i '/^LINK_LIBSIGCHAIN_LDFLAGS/ s/$/ -fstack-protector/' Makefile"
      system "sed -i '/^DSTBIN =/ s/.*/DSTBIN = #{CREW_DEST_PREFIX.gsub('/', '\/')}\\/bin/' Makefile"
      system "sed -i '/^DSTLIB =/ s/.*/DSTLIB = #{CREW_DEST_PREFIX.gsub('/', '\/')}\\/lib/' Makefile"
      system "make"
      system "make", "install"
    end
  end

  def self.postinstall
    puts "============================"
    puts "Krypton is now installed!"
    puts "'kr pair' will automatically configure ~/.ssh/config to use Krypton. To prevent this, export KR_SKIP_SSH_CONFIG=1"
    puts "============================"
  end
end
