require 'package'

class Kr < Package
  description 'Krypton command-line client, daemon, and SSH integration'
  homepage 'https://krypt.co'
  version '2.4.4'
  source_url 'https://raw.githubusercontent.com/kryptco/kr/master/README.md'
  source_sha256 'a0452783d22218a6fab914abbf5263459aaa1c8745512d7c4ebcf51fe08aaf7a'

  depends_on "gcc7" => :build
  depends_on "rust" => :build
  depends_on "go" => :build
  depends_on "pkgconfig" => :build
  depends_on "libsodium" => :build
  depends_on "rsync" => :build
  depends_on "buildessential" => :build
  depends_on "psmisc" => :build
  depends_on "git" => :build

  def self.install
    ENV["GOPATH"] = "#{Dir.pwd}/go"

    system "rustup", "target", "add", "wasm32-unknown-emscripten"
    system "cargo web --version || ( curl -Ls https://github.com/koute/cargo-web/archive/0.6.10.zip -o cargo-web.zip; unzip cargo-web.zip; cd cargo-web-0.6.10; cargo build --release && cargo install )"

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
