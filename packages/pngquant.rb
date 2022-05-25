require 'package'

class Pngquant < Package
  description 'Command-line utility and a library for lossy compression of PNG images.'
  homepage 'https://pngquant.org/'
  version '2.17.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/kornelski/pngquant.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pngquant/2.17.0_armv7l/pngquant-2.17.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pngquant/2.17.0_armv7l/pngquant-2.17.0-chromeos-armv7l.tar.zst',
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pngquant/2.17.0_i686/pngquant-2.17.0-chromeos-i686.tar.zst',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pngquant/2.17.0_x86_64/pngquant-2.17.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fdddb92cbb12abd1e267330768c58a0d31e8c743831dc2eff820d3b214af9e94',
     armv7l: 'fdddb92cbb12abd1e267330768c58a0d31e8c743831dc2eff820d3b214af9e94',
      i686: '38b281e502240992f6b27455d70211b08dfc5fa47f1b2d0a8fe2be687cca569a',
    x86_64: 'ed9748591b5eb81fc5565a003ee55549136d5d87052ad1b41ed9c0adf2e99457'
  })

  depends_on 'lcms'
  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release --features=lcms2'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'target/release/pngquant', "#{CREW_DEST_PREFIX}/bin/pngquant", mode: 0o755
  end
end
