require 'package'

class Sccache < Package
  description 'Shared Compilation Cache'
  homepage 'https://github.com/mozilla/sccache/'
  version '0.8.1'
  license 'Apache-2.0, Apache-2.0-with-LLVM-exceptions, BSD, BSD-2, Boost-1.0, ISC, MIT, Unlicense and ZLIB'
  compatibility 'all'
  source_url 'https://github.com/mozilla/sccache.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a9117b14992c77ce612ac399f90616d49a3c592fae5a9b572c1ba81e1c22f5f',
     armv7l: '1a9117b14992c77ce612ac399f90616d49a3c592fae5a9b572c1ba81e1c22f5f',
       i686: 'a81a1abe8eeac861e2476a866b7dc5ff08fe2136648b728b6d5587b0ce31bff2',
     x86_64: 'cd07df16f07b3052235b08bc5b20e7d5eb4a881bfef4d6b1fde39d93f8f25c07'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
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
    SCCACHEEOF
    FileUtils.install 'sccache_env', "#{CREW_DEST_PREFIX}/etc/env.d/00-sccache", mode: 0o644
  end
end
