require 'package'

class Exa < Package
  description 'Modern replacement for \'ls\''
  homepage 'https://the.exa.website'
  version '0.9.0'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/ogham/exa/archive/v0.9.0.tar.gz'
    source_sha256 '96e743ffac0512a278de9ca3277183536ee8b691a46ff200ec27e28108fef783'
    depends_on 'rust' => :build
    depends_on 'libgit2'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/exa-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/exa-0.9.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/exa-0.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '42133a358da6081dc28f67ce182ba414e14a1c73da85bdf8e573851b3bb8bf54',
     armv7l: '42133a358da6081dc28f67ce182ba414e14a1c73da85bdf8e573851b3bb8bf54',
     x86_64: '2d89beb090ae156c7c9192236e99c77c259885534cb200cb32ec2ae1dd2b525e',
  })

  def self.build
    system 'cargo build --release -v'
  end

  def self.check
#    system 'cargo test --all'
  end

  def self.install
    system "install -Dm755 target/release/exa #{CREW_DEST_PREFIX}/bin/exa"
  end
end
