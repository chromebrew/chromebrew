require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.43.1'
  source_url 'https://github.com/rust-lang/rust/archive/1.43.1.tar.gz'
  source_sha256 'f4347087837a566bef5b9252428bbd92c7e12f31e601868acaa62ec2adb1b1c2'

  binary_url ({
  })
  binary_sha256 ({
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
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('rustup.sh') ) == '79552216b4ccab5f773a981bc156b38b004a4f94ac5d2b83f8e127020a4d0bfe'
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
