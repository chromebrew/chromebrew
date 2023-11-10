require 'package'

class Kr < Package
  description 'Krypton command-line client, daemon, and SSH integration'
  homepage 'https://krypt.co'
  license 'all-rights-reserved' # Don't distribute binaries of this package: it's illegal.
  version '2.4.10'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'rust' => :build
  depends_on 'go' => :build
  depends_on 'libsodium' => :build
  depends_on 'rsync' => :build
  depends_on 'psmisc' => :build

  def self.install
    cargo_web_version = '0.6.26'
    cargo_web_sha256 = '51c6e627218a861e81f227768286bfaceda4d762ab23406d9427eb83bf4c2879'
    ENV['GOPATH'] = "#{Dir.pwd}/go"
    ENV['RUSTUP_HOME'] = "#{Dir.pwd}/.rustup"
    ENV['CARGO_HOME'] = "#{Dir.pwd}/.cargo"
    FileUtils.mkdir_p ENV.fetch('RUSTUP_HOME', nil).to_s
    FileUtils.mkdir_p ENV.fetch('CARGO_HOME', nil).to_s

    system 'rustup', 'install', 'stable'
    system 'rustup', 'default', 'stable'
    system 'rustup', 'target', 'add', 'wasm32-unknown-emscripten'

    system "curl -Ls https://github.com/koute/cargo-web/archive/#{cargo_web_version}.zip -o cargo-web.zip"
    abort 'Checksum mismatch. :/  Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('cargo-web.zip')) == cargo_web_sha256
    system 'unzip cargo-web.zip'
    FileUtils.cd("cargo-web-#{cargo_web_version}") do
      system 'cargo build --release && cargo install'
    end

    FileUtils.mkdir_p "#{Dir.pwd}/go/src"
    system 'go get github.com/kryptco/kr'
    FileUtils.cd('go/src/github.com/kryptco/kr') do
      ENV['PREFIX'] = CREW_PREFIX
      ENV['PWD'] = Dir.pwd
      system "git checkout tags/#{version}"
      system 'git submodule update --init --recursive'
      system 'git checkout -- Makefile'
      system "sed -i '/^LINK_LIBSIGCHAIN_LDFLAGS/ s/$/ -fstack-protector/' Makefile"
      system "sed -i '/^DSTBIN =/ s/.*/DSTBIN = #{CREW_DEST_PREFIX.gsub('/', '\/')}\\/bin/' Makefile"
      system "sed -i '/^DSTLIB =/ s/.*/DSTLIB = #{CREW_DEST_PREFIX.gsub('/', '\/')}\\/lib/' Makefile"
      system 'make'
      system 'make', 'install'
    end
  end

  def self.postinstall
    puts '============================'.lightblue
    puts 'Krypton is now installed!'.lightblue
    puts "'kr pair' will automatically configure ~/.ssh/config to use Krypton. To prevent this, export KR_SKIP_SSH_CONFIG=1".lightblue
    puts '============================'.lightblue
  end
end
