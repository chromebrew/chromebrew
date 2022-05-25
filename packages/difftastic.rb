require 'package'

class Difftastic < Package
  description 'Difftastic is a structural diff tool that compares files based on their syntax.'
  homepage 'https://github.com/Wilfred/difftastic'
  version '0.52.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/Wilfred/difftastic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/difftastic/0.52.0_armv7l/difftastic-0.52.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/difftastic/0.52.0_armv7l/difftastic-0.52.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/difftastic/0.52.0_i686/difftastic-0.52.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/difftastic/0.52.0_x86_64/difftastic-0.52.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54412e3711977b6cc829490a847844c12cfe5fd1898b2c9ae4d10b640df91e41',
     armv7l: '54412e3711977b6cc829490a847844c12cfe5fd1898b2c9ae4d10b640df91e41',
       i686: '8c6df5d2ae0941782dd53136e6912837b6ba364929fabaa0d29252f24c22a1bb',
     x86_64: '555b7c11f0b13166e5dd9ca3c826fd5c730f93cb0e2bce167a26f4b9b8fb1386'
  })

  depends_on 'rust' => :build

  def self.install
    system "cargo install \
      --locked difftastic \
      --path . --root #{CREW_DEST_PREFIX}"
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/.crate*"]
  end

  def self.postinstall
    puts "\nType 'difft' to get started.\n".lightblue
  end
end
