require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  @_ver = '1.50.0'
  version "#{@ver}-1"
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url "https://github.com/rust-lang/rust/archive/#{@_ver}.tar.gz"
  source_sha256 '112114380a4f4ec98c30313ce9047183ee0c95ef2b28beeb7b77e6cd47a9294e'

  def self.install
    ENV['RUST_BACKTRACE'] = 'full'
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    ENV['CARGO_HOME'] = "#{CREW_DEST_PREFIX}/share/cargo"
    ENV['RUSTUP_HOME'] = "#{CREW_DEST_PREFIX}/share/rustup"
    case ARCH
    when 'aarch64', 'armv7l'
      default_host = 'armv7-unknown-linux-gnueabihf'
    else
      default_host = "#{ARCH}-unknown-linux-gnu"
    end
    system 'curl -Lf https://sh.rustup.rs -o rustup.sh'
    unless Digest::SHA256.hexdigest(File.read('rustup.sh')) == 'fa50ccf79c30ce9446cc45917e8ea10655674c2a9509221cb12bd865c60ab709'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    system "sed -i 's,\$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_PREFIX}/tmp,' rustup.sh"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/bin")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/cargo")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/rustup")
    system "RUSTFLAGS='-Clto=thin' bash ./rustup.sh -y --no-modify-path --default-host #{default_host} --default-toolchain stable --profile minimal"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/cargo/bin") do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/cargo/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    system "install -Dm644 #{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/etc/bash_completion.d/cargo #{CREW_DEST_PREFIX}/share/bash-completion/completions/cargo"
    FileUtils.rm("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/etc/bash_completion.d/cargo")
    system "touch #{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
    FileUtils.mv("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/share/man/",
                 "#{CREW_DEST_PREFIX}/share/")
    FileUtils.rm_rf("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/share/doc/")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/cargo", "#{CREW_DEST_HOME}/.cargo")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/rustup", "#{CREW_DEST_HOME}/.rustup")

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Rustup and cargo configuration
      export CARGO_HOME=#{CREW_PREFIX}/share/cargo
      export RUSTUP_HOME=#{CREW_PREFIX}/share/rustup
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/rust", @env)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Rustup and cargo bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/cargo
      source #{CREW_PREFIX}/share/bash-completion/completions/rustup
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/rust", @env)
    system "rustup completions bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
  end
end
