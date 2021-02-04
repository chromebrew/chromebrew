# frozen_string_literal: true

require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  @_ver = '1.49.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/rust-lang/rust/archive/#{@_ver}.tar.gz"
  source_sha256 'cfa4c9bb38237ffdd90d9956c030222734f4a8cb5c82b1871131ece609be5b8f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.49.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.49.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.49.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.49.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5cbf198ee275ad76dfd135bf8840b5a254d14807d0dad6455e17406922f11dc1',
     armv7l: '5cbf198ee275ad76dfd135bf8840b5a254d14807d0dad6455e17406922f11dc1',
       i686: 'e4892bac42d8dab3e942c6e2b273dff291cf87c7afdd82cdf9461a0fdf10354e',
     x86_64: '5e7e8489b26bae08c8f8907d816e7d1b528b5d5b55d77ffc80ad8a7ccfb05f08'
  })

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
  end

  def self.postinstall
    system "rustup completions bash > #{CREW_PREFIX}/share/bash-completion/completions/rustup"
    rust_in_bashrc = `grep -c "RUSTUP_HOME" ~/.bashrc || true`
    unless rust_in_bashrc.to_i.positive?
      puts 'Putting RUST code in ~/.bashrc'.lightblue
      system "echo 'export CARGO_HOME=#{CREW_PREFIX}/share/cargo' >> ~/.bashrc"
      system "echo 'export RUSTUP_HOME=#{CREW_PREFIX}/share/rustup' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
    puts
    puts 'To add bash completion for cargo, execute the following:'.lightblue
    puts "echo '# cargo completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/bash-completion/completions/cargo ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/completions/cargo' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
    puts 'To add bash completion for rustup, execute the following:'.lightblue
    puts "echo '# rustup completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/bash-completion/completions/rustup ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/completions/rustup' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
  end
end
