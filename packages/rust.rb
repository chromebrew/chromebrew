require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  @_ver = '1.55.0'
  version @_ver
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rust/1.55.0_i686/rust-1.55.0-chromeos-i686.tpxz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rust/1.55.0_armv7l/rust-1.55.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rust/1.55.0_armv7l/rust-1.55.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rust/1.55.0_x86_64/rust-1.55.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: 'bce668e6278d073b9f66d7a1b5980d1a5f350b254aa18af03757ab6e72cc030b',
    aarch64: 'bb532ba4a0bac36d4321b154bf2b726aa031eaaca2670ca426f544f22cd94cf4',
     armv7l: 'bb532ba4a0bac36d4321b154bf2b726aa031eaaca2670ca426f544f22cd94cf4',
     x86_64: 'd25d432ff1294fd0ab95e71951f6271d19e9dbdebede5f47defdb6abe909e96a'
  })

  def self.install
    ENV['RUST_BACKTRACE'] = 'full'
    ENV['CARGO_HOME'] = "#{CREW_DEST_PREFIX}/share/cargo"
    ENV['RUSTUP_HOME'] = "#{CREW_DEST_PREFIX}/share/rustup"
    default_host = ARCH == 'aarch64' || ARCH == 'armv7l' ? 'armv7-unknown-linux-gnueabihf' : "#{ARCH}-unknown-linux-gnu"
    system 'curl -Lf https://sh.rustup.rs -o rustup.sh'
    unless Digest::SHA256.hexdigest(File.read('rustup.sh')) == 'a3cb081f88a6789d104518b30d4aa410009cd08c3822a1226991d6cf0442a0f8'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    system "sed -i 's,\$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_PREFIX}/tmp,' rustup.sh"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/bin")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/cargo")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/rustup")
    system "RUSTFLAGS='-Clto=thin' bash ./rustup.sh -y --no-modify-path --default-host #{default_host} --default-toolchain #{@_ver} --profile minimal"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/cargo/bin") do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/cargo/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    system "install -Dm644 #{CREW_DEST_PREFIX}/share/rustup/toolchains/#{@_ver}-#{default_host}/etc/bash_completion.d/cargo #{CREW_DEST_PREFIX}/share/bash-completion/completions/cargo"
    FileUtils.rm("#{CREW_DEST_PREFIX}/share/rustup/toolchains/#{@_ver}-#{default_host}/etc/bash_completion.d/cargo")
    system "touch #{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
    FileUtils.mv("#{CREW_DEST_PREFIX}/share/rustup/toolchains/#{@_ver}-#{default_host}/share/man/",
                 "#{CREW_DEST_PREFIX}/share/")
    FileUtils.rm_rf("#{CREW_DEST_PREFIX}/share/rustup/toolchains/#{@_ver}-#{default_host}/share/doc/")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/cargo", "#{CREW_DEST_HOME}/.cargo")
    FileUtils.ln_sf("#{CREW_PREFIX}/share/rustup", "#{CREW_DEST_HOME}/.rustup")

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @rustconfigenv = <<~RUSTCONFIGEOF
      # Rustup and cargo configuration
      export CARGO_HOME=#{CREW_PREFIX}/share/cargo
      export RUSTUP_HOME=#{CREW_PREFIX}/share/rustup
    RUSTCONFIGEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/rust", @rustconfigenv)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @rustcompletionenv = <<~RUSTCOMPLETIONEOF
      # Rustup and cargo bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/cargo
      source #{CREW_PREFIX}/share/bash-completion/completions/rustup
    RUSTCOMPLETIONEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/rust", @rustcompletionenv)
    system "#{CREW_DEST_PREFIX}/share/cargo/bin/rustup completions bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      Dir['*'] do |f|
        FileUtils.ln_sf "../share/cargo/bin/#{f}", f
      end
    end
  end

  def self.remove
    config_dirs = %W[#{HOME}/.rustup #{CREW_PREFIX}/share/rustup #{HOME}/.cargo #{CREW_PREFIX}/share/cargo]
    system "echo #{config_dirs}"
    print "\nWould you like to remove the config directories above? [y/N] "
    case $stdin.getc
    when 'y', 'Y'
      FileUtils.rm_rf config_dirs
      puts "#{config_dirs} removed.".lightred
    else
      puts "#{config_dirs} saved.".lightgreen
    end
  end
end
