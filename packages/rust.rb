require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.47.0'
  compatibility 'all'
  source_url 'https://github.com/rust-lang/rust/archive/1.47.0.tar.gz'
  source_sha256 'fb63501399742c9302684a2dbeffbf2d9020ab2f7f2256ea2545545ae05cf914'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.47.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.47.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.47.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.47.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '64f9602aab40ba27eb76983c5b41ad909934d322230af7f9db961fdb75635fa6',
     armv7l: '64f9602aab40ba27eb76983c5b41ad909934d322230af7f9db961fdb75635fa6',
       i686: '2ac7f529289f85104c855048b9187c408201c6a12e986d4366f40a93f733dff2',
     x86_64: '87c0ed348981773b411cc6e12fdcea7426fc2a48753680bbbe3cd78e7148e453',
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
      default_host = ARCH + '-unknown-linux-gnu'
    end
    system 'curl -Ls https://sh.rustup.rs -o rustup.sh'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('rustup.sh') ) == '8928261388c8fae83bfd79b08d9030dfe21d17a8b59e9dcabda779213f6a3d14'
    system "sed -i 's,\$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_PREFIX}/tmp,' rustup.sh"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/cargo')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/rustup')
    system "bash ./rustup.sh -y --no-modify-path --default-host #{default_host} --default-toolchain stable --profile minimal"
    FileUtils.cd(CREW_DEST_PREFIX + '/share/cargo/bin') do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/cargo/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    system "install -Dm644 #{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/etc/bash_completion.d/cargo #{CREW_DEST_PREFIX}/share/bash-completion/completions/cargo"
    FileUtils.rm("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/etc/bash_completion.d/cargo")
    system "touch #{CREW_DEST_PREFIX}/share/bash-completion/completions/rustup"
    FileUtils.mv("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/share/man/", "#{CREW_DEST_PREFIX}/share/")
    FileUtils.rm_rf("#{CREW_DEST_PREFIX}/share/rustup/toolchains/stable-#{default_host}/share/doc/")
    FileUtils.ln_sf(CREW_PREFIX + '/share/cargo', CREW_DEST_HOME + '/.cargo')
    FileUtils.ln_sf(CREW_PREFIX + '/share/rustup', CREW_DEST_HOME + '/.rustup')
  end

  def self.postinstall
    system "rustup completions bash > #{CREW_PREFIX}/share/bash-completion/completions/rustup"
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export CARGO_HOME=#{CREW_PREFIX}/share/cargo' >> ~/.bashrc".lightblue
    puts "echo 'export RUSTUP_HOME=#{CREW_PREFIX}/share/rustup' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To add bash completion for cargo, execute the following:".lightblue
    puts "echo '# cargo completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/bash-completion/completions/cargo ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/completions/cargo' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To add bash completion for rustup, execute the following:".lightblue
    puts "echo '# rustup completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/bash-completion/completions/rustup ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/bash-completion/completions/rustup' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
