require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.86.0'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/rust-lang/rustup.git'
  git_hashtag '1.28.1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7514b7ad5d583568e4da0bbfa89d7890832d988141b795bbdd0ceed9a3046b4',
     armv7l: 'c7514b7ad5d583568e4da0bbfa89d7890832d988141b795bbdd0ceed9a3046b4',
       i686: '70b0a607832cc2d488a366f0afd74a83c59fbc8a4ea45a2fc735a764049fb680',
     x86_64: 'b2252c5f4e35280e334f9a39a5d3e95a6adb4fc3185c7fc4108a8c026748938c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlib' # R

  no_strip
  no_shrink
  print_source_bashrc

  def self.install
    ENV['RUSTUP_PERMIT_COPY_RENAME'] = 'unstable'
    ENV['RUSTUP_INIT_SKIP_PATH_CHECK'] = 'yes'
    ENV['RUST_BACKTRACE'] = 'full'
    ENV['CARGO_HOME'] = "#{CREW_DEST_PREFIX}/share/cargo"
    ENV['RUSTUP_HOME'] = "#{CREW_DEST_PREFIX}/share/rustup"
    default_host = %w[aarch64 armv7l].include?(ARCH) ? 'armv7-unknown-linux-gnueabihf' : "#{ARCH}-unknown-linux-gnu"
    system "sed -i 's,$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_PREFIX}/tmp,' rustup-init.sh"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/cargo")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/rustup")
    system "RUSTFLAGS='-Clto=thin' bash ./rustup-init.sh -y --no-modify-path --default-host #{default_host} --default-toolchain #{version} --profile minimal"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/bash-completion/completions/")
    FileUtils.touch "#{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
    FileUtils.mv("#{CREW_DEST_PREFIX}/share/rustup/toolchains/#{version}-#{default_host}/share/man/",
                 "#{CREW_DEST_PREFIX}/share/")
    FileUtils.rm_rf("#{CREW_DEST_PREFIX}/share/rustup/toolchains/#{version}-#{default_host}/share/doc/")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/cargo", "#{CREW_DEST_HOME}/.cargo")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/rustup", "#{CREW_DEST_HOME}/.rustup")

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    system "sed -i 's,#{CREW_DEST_PREFIX}/share/cargo,#{CREW_PREFIX}/share/cargo,g' #{CREW_DEST_PREFIX}/share/cargo/env"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/rust", <<~RUSTCONFIGEOF
      # Rustup and cargo configuration
      export CARGO_HOME=#{CREW_PREFIX}/share/cargo
      export RUSTUP_HOME=#{CREW_PREFIX}/share/rustup
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
    system "#{CREW_PREFIX}/share/cargo/bin/rustup default stable"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.rustup")
    Package.agree_to_remove("#{CREW_PREFIX}/share/rustup")
    Package.agree_to_remove("#{HOME}/.cargo")
    Package.agree_to_remove("#{CREW_PREFIX}/share/cargo")
  end
end
