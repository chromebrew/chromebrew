require 'package'

class Hurl < Package
  description 'Hurl is a command line tool that runs HTTP requests defined in a simple plain text format.'
  homepage 'https://hurl.dev/'
  version '4.1.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/Orange-OpenSource/hurl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/hurl/4.1.0_x86_64/hurl-4.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '59132b9e9ab44687e074a9417e8172a3e09653ac1256df9fa7dd38ecc5b341f0'
  })

  depends_on 'rust' => :build
  depends_on 'curl'
  depends_on 'libxml2'
  depends_on 'openssl'

  def self.build
    system 'cargo build --release'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    Dir.chdir 'target/release' do
      FileUtils.install %w[hurl hurlfmt], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    end
    Dir.chdir 'docs/manual' do
      FileUtils.install %w[hurl.1 hurlfmt.1], "#{CREW_DEST_MAN_PREFIX}/man1", mode: 0o644
    end
  end
end
