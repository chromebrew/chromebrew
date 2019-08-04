require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.36.0'
  source_url 'https://raw.githubusercontent.com/rust-lang/rust/1.36.0/RELEASES.md'
  source_sha256 '62b5a3f4ffaa57660478b3aab8b6f5bf317f56c0383d6319a857d14b578266c4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.36.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.36.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.36.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.36.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b55ca1105496ba207481714886de91c6f58f73cb32574909cd8b6d134250fe7',
     armv7l: '9b55ca1105496ba207481714886de91c6f58f73cb32574909cd8b6d134250fe7',
       i686: 'c4c9b73f3524cd0d6eb825349805ac610cb855bc4ccf305fbe6238af5e672de5',
     x86_64: '925811fd3709aa42d90173d75422f0869e6738ade8fedcf8820ae748f0c5363d',
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
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('rustup.sh') ) == '9bbf4987fc0b46658249c176004271bebc3126530cb2aff347776a9549a48321'
    system "sed -i 's,\$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_PREFIX}/tmp,' rustup.sh"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/cargo')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/rustup')
    system "bash ./rustup.sh -y --no-modify-path --default-host #{default_host} --default-toolchain stable"
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
