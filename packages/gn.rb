require 'package'

class Gn < Package
  description 'GN is a meta-build system that generates build files for Ninja.'
  homepage 'https://gn.googlesource.com/gn/'
  version 'b2afae1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gn.googlesource.com/gn'
  git_hashtag 'b2afae122eeb6ce09c52d63f67dc53fc517dbdc8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6859e645fd0fcb8c4fe3149af0d6be8e4bb1988d0ac3fbba4316a253b473a354',
     armv7l: '6859e645fd0fcb8c4fe3149af0d6be8e4bb1988d0ac3fbba4316a253b473a354',
       i686: '15f7ea0b5f31b5a7a82ac670388d44404824049c434c4699189ce4ef58930634',
     x86_64: '1d0365f7a3ca6efd7a80c15515e198e3d6fe02dfb1c312ef0ac565fcc0ee4ae3'
  })

  depends_on 'python3' => :build

  # The build process uses git describe to determine the version.
  git_clone_deep
  git_fetchtags

  def self.build
    # With the large llvm dependency and problems with -Wunused-command-line-argument, it's easier just to override the default value of clang++.
    # https://gn.issues.chromium.org/issues/42440280
    system "CXX=g++ #{'CFLAGS=-Wno-unused-value' if ARCH.eql?('armv7l')} python build/gen.py"
    system "#{CREW_NINJA} -C out"
  end

  def self.check
    system './out/gn_unittests'
  end

  def self.install
    FileUtils.install 'out/gn', "#{CREW_DEST_PREFIX}/bin/gn", mode: 0o755
  end
end
