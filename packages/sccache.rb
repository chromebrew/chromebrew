require 'package'

class Sccache < Package
  description 'Shared Compilation Cache'
  homepage 'https://github.com/mozilla/sccache/'
  version '0.8.0'
  license 'Apache-2.0, Apache-2.0-with-LLVM-exceptions, BSD, BSD-2, Boost-1.0, ISC, MIT, Unlicense and ZLIB'
  compatibility 'x86_64'
  # See https://github.com/mozilla/sccache/issues/656 for non-x86_64 compatibility info.
  source_url 'https://github.com/mozilla/sccache.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '0096deae23c77a2c0a97e70a8d2a64967ccd9c92be52a45c8b0169f9296e5b9d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'openssl' # R
  depends_on 'rust' => :build

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
    File.write 'start_sccache', <<~START_SCCACHEEOF
      #!/bin/bash
      if [[ $(pgrep -wc sccache) > 1 ]]; then
        # distccd is already running.
        # Return or exit depending upon whether script was sourced.
        (return 0 2>/dev/null) && return 0 || exit 0
      fi
      sccache --start-server
    START_SCCACHEEOF
    FileUtils.install 'start_sccache', "#{CREW_DEST_PREFIX}/bin/startsccache", mode: 0o755
    File.write 'sccache_env', <<~SCCACHEEOF
      # Sccache configuration
      SCCACHE_IGNORE_SERVER_IO_ERROR=1
      RUSTC_WRAPPER=#{CREW_PREFIX}/bin/sccache
      if [[ $PATH != *"ccache/bin"* ]]; then
        PATH="#{CREW_LIB_PREFIX}/ccache/bin:$PATH"
      fi
    SCCACHEEOF
    File.write 'stop_sccache', <<~STOP_SCCACHEEOF
      #!/bin/bash
      sccache --stop-server
    STOP_SCCACHEEOF
    FileUtils.install 'stop_sccache', "#{CREW_DEST_PREFIX}/bin/stopsccache", mode: 0o755
    File.write 'restart_sccache', <<~RESTART_SCCACHEEOF
      #!/bin/bash
      sccache --stop-server
      sccache --start-server
    RESTART_SCCACHEEOF
    FileUtils.install 'restart_sccache', "#{CREW_DEST_PREFIX}/bin/restartsccache", mode: 0o755
    FileUtils.install 'sccache_env', "#{CREW_DEST_PREFIX}/etc/env.d/00-sccache", mode: 0o644
    # start sccache server from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
    File.write 'bashd_sccache', <<~BASHDSCCACHE_EOF
      [[ $(pgrep -wc sccache) > 1 ]] || source #{CREW_PREFIX}/bin/startscccache
    BASHDSCCACHE_EOF
    FileUtils.install 'bashd_sccache', "#{CREW_DEST_PREFIX}/etc/bash.d/sccache", mode: 0o644
  end
end
