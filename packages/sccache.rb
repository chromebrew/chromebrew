require 'package'

class Sccache < Package
  description 'Shared Compilation Cache'
  homepage 'https://github.com/mozilla/sccache/'
  version '0.10.0'
  license 'Apache-2.0, Apache-2.0-with-LLVM-exceptions, BSD, BSD-2, Boost-1.0, ISC, MIT, Unlicense and ZLIB'
  compatibility 'all'
  source_url 'https://github.com/mozilla/sccache.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da53d5b3c9b4a1068165964677a7b72ddd199a61606ed2ffe2a0d4f092b9934f',
     armv7l: 'da53d5b3c9b4a1068165964677a7b72ddd199a61606ed2ffe2a0d4f092b9934f',
       i686: 'b4eeef08d3faaef139266ce63138104e2a60946390c5c4c0ff722e05717306f6',
     x86_64: 'ca129f687034ad50817356cc796679a3c9d54280137690ba96ae82af9eea26cc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build

  print_source_bashrc

  def self.patch
    # Enable builds for non-x86_64.
    # See https://github.com/mozilla/sccache/issues/656 for non-x86_64 compatibility info.
    system "sed -i 's/all(target_os = \"linux\", target_arch = \"x86_64\")/target_os = \"linux\"/' src/bin/sccache-dist/main.rs"
  end

  def self.build
    system "cargo fetch \
      --manifest-path Cargo.toml"
    system "LDFLAGS+=' -lzstd' cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml \
      --features all,dist-server,native-zlib"
  end

  def self.install
    system "LDFLAGS+=' -lzstd' cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX} \
      --features all,dist-server,native-zlib"
    File.write 'sccache_env', <<~SCCACHEEOF
      # Sccache configuration
      SCCACHE_IGNORE_SERVER_IO_ERROR=1
      SCCACHE_DIRECT=true
      RUSTC_WRAPPER=#{CREW_PREFIX}/bin/sccache
      if [[ -f /.dockerenv ]]; then
        if [[ -d /output/ ]]; then
          SCCACHE_DIR="/output/.sccache/$(uname -m)"
          mkdir -p "${SCCACHE_DIR}"
        fi
        # scacche configuration is as per
        # https://github.com/mozilla/sccache/blob/main/docs/Configuration.md
        # The default sccache config is looked for at:
        #  ~/.config/sccache/config
        if [[ -f /output/.sccache/$(uname -m)-config ]]; then
          SCCACHE_CONF="/output/.sccache/sccache-$(uname -m)-config"
        fi
      fi
      RUSTC_WRAPPER=#{CREW_PREFIX}/bin/sccache
      # Set a unique port to use for SCCACHE
      case $( uname -m ) in
        i686)          SCCACHE_SERVER_PORT=4236;;
        armv7l|armv8l) SCCACHE_SERVER_PORT=4246;;
        aarch64)       SCCACHE_SERVER_PORT=4256;;
        x86_64)        SCCACHE_SERVER_PORT=4266;;
        *)             SCCACHE_SERVER_PORT=4276;;
      esac
    SCCACHEEOF
    FileUtils.install 'sccache_env', "#{CREW_DEST_PREFIX}/etc/env.d/00-sccache", mode: 0o644
    File.write 'bashd_sccache', <<~BASHDSCCACHE_EOF
      # Start sccache if the sccache server for this architecture is not running.
      if [[ $(pgrep -wc sccache) -lt 1 ]]; then
        true &>/dev/null </dev/tcp/127.0.0.1/$SCCACHE_SERVER_PORT || sccache --start-server
      fi
    BASHDSCCACHE_EOF
    FileUtils.install 'bashd_sccache', "#{CREW_DEST_PREFIX}/etc/bash.d/sccache", mode: 0o644
  end
end
