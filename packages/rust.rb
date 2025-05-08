require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.86.0-5'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/rust-lang/rustup.git'
  git_hashtag '1.28.2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd833484999d92e034c83460cd5079c195cfdb4d27bd81d2c4f5436893227dfb0',
     armv7l: 'd833484999d92e034c83460cd5079c195cfdb4d27bd81d2c4f5436893227dfb0',
       i686: '3360be0df39866d180f949f461a93eb752f1f870d1f64d732e4fb1423e873bba',
     x86_64: 'e937243be9789c83635a244441fb8625eb48c1ed00396472c4467b427406f3f7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  no_strip
  print_source_bashrc

  def self.install
    ENV['RUSTUP_PERMIT_COPY_RENAME'] = 'unstable'
    ENV['RUSTUP_INIT_SKIP_PATH_CHECK'] = 'yes'
    ENV['RUST_BACKTRACE'] = 'full'
    ENV['CARGO_HOME'] = "#{CREW_DEST_PREFIX}/share/cargo"
    ENV['RUSTUP_HOME'] = "#{CREW_DEST_PREFIX}/share/rustup"
    ENV['RUSTFLAGS'] = "-Cdebuginfo=0 -Copt-level=3 -Clink-arg=-fuse-ld=mold -Clink-arg=-Wl,--dynamic-linker,#{CREW_GLIBC_INTERPRETER} -Clink-arg=-Wl,-rpath,#{CREW_GLIBC_PREFIX}:#{CREW_LIB_PREFIX} -Clink-arg=-L#{CREW_GLIBC_PREFIX} -Clink-arg=-L#{CREW_LIB_PREFIX}"

    ENV['RUSTUP_TOOLCHAIN'] = 'stable'
    default_host = %w[aarch64 armv7l].include?(ARCH) ? 'armv7-unknown-linux-gnueabihf' : "#{ARCH}-unknown-linux-gnu"
    system "sed -i 's,$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_PREFIX}/tmp,' rustup-init.sh"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/cargo")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/rustup")
    system "bash ./rustup-init.sh -y --no-modify-path --default-host #{default_host} --default-toolchain #{ENV.fetch('RUSTUP_TOOLCHAIN', nil)} --profile default"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/bash-completion/completions/")
    FileUtils.touch "#{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
    FileUtils.mv("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/share/man/",
                 "#{CREW_DEST_PREFIX}/share/")
    FileUtils.rm_rf("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/share/doc/")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/cargo", "#{CREW_DEST_HOME}/.cargo")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/rustup", "#{CREW_DEST_HOME}/.rustup")

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    system "sed -i 's,#{CREW_DEST_PREFIX}/share/cargo,#{CREW_PREFIX}/share/cargo,g' #{CREW_DEST_PREFIX}/share/cargo/env"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/rust", <<~RUSTCONFIGEOF
      # Rustup and cargo configuration
      export CARGO_HOME=#{ENV.fetch('CARGO_HOME', nil).gsub(CREW_DEST_PREFIX, CREW_PREFIX)}
      export RUSTFLAGS="#{ENV.fetch('RUSTFLAGS', nil)}"
      export RUSTUP_HOME=#{ENV.fetch('RUSTUP_HOME', nil).gsub(CREW_DEST_PREFIX, CREW_PREFIX)}
      export RUSTUP_TOOLCHAIN=#{ENV.fetch('RUSTUP_TOOLCHAIN', nil)}
      source #{CREW_PREFIX}/share/cargo/env
    RUSTCONFIGEOF

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/rust", <<~RUSTCOMPLETIONEOF
      # Rustup and cargo bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/rustup
    RUSTCOMPLETIONEOF
    system "#{CREW_DEST_PREFIX}/share/cargo/bin/rustup completions bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
  end

  def self.postinstall
    # This may eventually not be needed, as there is no rpath hard coded
    # into the rust binaries by default, but this does currently fix
    # building with rust, especially for building gcc 15.1.
    # This isn't being done in the build section since currently crew
    # strips rpaths during install.
    puts 'Updating rpaths for rust...'.lightblue
    default_host = %w[aarch64 armv7l].include?(ARCH) ? 'armv7-unknown-linux-gnueabihf' : "#{ARCH}-unknown-linux-gnu"
    Dir["#{CREW_PREFIX}/share/rustup/toolchains/stable-#{default_host}/bin/*"].each do |bin|
      system "patchelf --set-rpath #{CREW_GLIBC_PREFIX}:#{CREW_PREFIX}/share/rustup/toolchains/stable-#{default_host}/lib #{bin}", exception: false if IO.popen(['file', '--brief', '--mime-type', bin], &:read).chomp == 'application/x-pie-executable'
    end
  end

  def self.postremove
    # This replicates the actions of 'rustup self uninstall'.
    Package.agree_to_remove("#{HOME}/.rustup")
    # Delete RUSTUP_HOME
    Package.agree_to_remove("#{CREW_PREFIX}/share/rustup")
    Package.agree_to_remove("#{HOME}/.cargo")
    # Delete CARGO_HOME
    Package.agree_to_remove("#{CREW_PREFIX}/share/cargo")
  end
end
