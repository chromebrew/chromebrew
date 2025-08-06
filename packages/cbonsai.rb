require 'package'

class Cbonsai < Package
  description 'A CLI bonsai tree generator, grow bonsai trees in our terminal'
  homepage 'https://gitlab.com/jallbrit/cbonsai'
  version '1.4.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gitlab.com/jallbrit/cbonsai.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b17845d4f5c458f688455d9a50b67cef7859c7eb0c997f63d955d75f4581fa9',
     armv7l: '5b17845d4f5c458f688455d9a50b67cef7859c7eb0c997f63d955d75f4581fa9',
       i686: 'ca68a47382e3b61d305d79717d2568b3d3ea77dffc3c57db6bcbf822b73e9873',
     x86_64: '5b3d01413c56c88d1801cdfcd432db1a54a5ab41a8b379187b938ce3dce9efd3'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'scdoc' => :build

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
