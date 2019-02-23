require 'package'

class Rust < Package
  description 'Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.'
  homepage 'https://www.rust-lang.org/'
  version '1.32.0'
  source_url 'https://raw.githubusercontent.com/rust-lang/rust/1.32.0/RELEASES.md'
  source_sha256 'df6b99927285143d5296c6c9b5bf4211dae7c3170624e410a1b708935dd90314'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.32.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rust-1.32.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7a235ab8da40dc9dd5fb3db6cf8fd04744ec20b7c3eb68cfd39ea32722cf5732',
     armv7l: '7a235ab8da40dc9dd5fb3db6cf8fd04744ec20b7c3eb68cfd39ea32722cf5732',
     x86_64: 'cd235a8998415b5456a709158188294296fe47f3ae147d033537046d8a716245',
  })

  def self.install
    if ARCH == 'armv7l'
      default_host = 'armv7-unknown-linux-gnueabihf'
    else
      default_host = ARCH + '-unknown-linux-gnu'
    end
    system 'curl -Ls https://sh.rustup.rs -o rust.sh'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('rust.sh') ) == '40328ad8fa5cfc15cdb0446bb812a4bba4c22b5aee195cfb8d64b8ef1de5879c'
    system "sed -i 's,\$(mktemp -d 2>/dev/null || ensure mktemp -d -t rustup),#{CREW_DEST_DIR},' rust.sh"
    FileUtils.rm_rf(HOME + '/.cargo')
    FileUtils.rm_rf(HOME + '/.rustup')
    system "bash ./rust.sh -y --no-modify-path --default-host #{default_host} --default-toolchain stable"
    FileUtils.mkdir_p(CREW_DEST_HOME)
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/cargo')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/share/rustup')
    FileUtils.cp_r(HOME + '/.cargo/.', CREW_DEST_PREFIX + '/share/cargo')
    FileUtils.cp_r(HOME + '/.rustup/.', CREW_DEST_PREFIX + '/share/rustup')
    FileUtils.cd(CREW_DEST_PREFIX + '/share/cargo/bin') do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/cargo/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
    FileUtils.ln_s(CREW_PREFIX + '/share/cargo', CREW_DEST_HOME + '/.cargo')
    FileUtils.ln_s(CREW_PREFIX + '/share/rustup', CREW_DEST_HOME + '/.rustup')
  end
end
