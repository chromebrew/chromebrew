require 'package'

class Fd < Package
  description "A simple, fast and user-friendly alternative to 'find'."
  homepage 'https://github.com/sharkdp/fd/'
  @_ver = '8.3.0'
  version "#{@_ver}-1"
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/sharkdp/fd.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fd/8.3.0-1_armv7l/fd-8.3.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fd/8.3.0-1_armv7l/fd-8.3.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fd/8.3.0-1_i686/fd-8.3.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fd/8.3.0-1_x86_64/fd-8.3.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1325765ea06369318274a4c9432b22cff9a6714b15afd7c6d61ab833166852f3',
     armv7l: '1325765ea06369318274a4c9432b22cff9a6714b15afd7c6d61ab833166852f3',
       i686: '7c39bc4ee7d48d65baea2e20a5573ba48a285c00a6e1816809a04749f657a15a',
     x86_64: '076f8e237125bcd488bdcf72a4f6a6f3e0786de795fb19444ec30c288f421965'
  })

  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zsh/site-functions/"
    FileUtils.install 'target/release/fd', "#{CREW_DEST_PREFIX}/bin/fd", mode: 0o755
    FileUtils.install `find . -name 'fd.bash' -type f`.to_s.chomp,
                      "#{CREW_DEST_PREFIX}/share/bash-completion/completions/fd"
    FileUtils.install 'doc/fd.1', "#{CREW_DEST_MAN_PREFIX}/man1/fd.1"
    FileUtils.install 'contrib/completion/_fd', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_fd"
  end

  def self.check
    system 'cargo test --release'
  end
end
