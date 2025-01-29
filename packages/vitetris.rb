require 'package'

class Vitetris < Package
  description 'Classic multiplayer tetris for the terminal'
  homepage 'https://www.victornils.net/tetris/'
  version '0.59.1'
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'https://github.com/vicgeralds/vitetris.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69b94bfbcf0fd6ab0744745f0f9512aa2de9eab0dd7ec97cd9603d085173c8cf',
     armv7l: '69b94bfbcf0fd6ab0744745f0f9512aa2de9eab0dd7ec97cd9603d085173c8cf',
       i686: '0cdc60d994383f1182c61e9a07baa1686c9ad2f83d658f320223fba7e522adae',
     x86_64: 'c5c834cd261fa11aa24d69f076dc6af1608a743bf0d3740d0d15f65a00ef7dd6'
  })

  depends_on 'curl' => :build
  depends_on 'llvm' => :build
  depends_on 'buildessential' => :build
  depends_on 'glibc' # R

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make CFLAGS="-O3 -pipe -Wno-error=implicit-int -Wno-error=implicit-function-declaration"'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.postinstall
    ExitMessage.add "\nUse command 'tetris' to launch Vitetris.\n"
  end
end
