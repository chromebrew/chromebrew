require 'package'

class Graphite < Package
  description 'Reimplementation of the SIL Graphite text processing engine'
  homepage 'https://github.com/silnrsi/graphite'
  version '2757274'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/silnrsi/graphite.git'
  git_hashtag '27572742003b93dc53dc02c01c237b72c6c25f54'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/2757274_armv7l/graphite-2757274-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/2757274_armv7l/graphite-2757274-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/2757274_i686/graphite-2757274-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphite/2757274_x86_64/graphite-2757274-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'db258e3b6e5c9809d0d2f95bcbda19fd8bb989667f722282e5284745cc3a20e4',
     armv7l: 'db258e3b6e5c9809d0d2f95bcbda19fd8bb989667f722282e5284745cc3a20e4',
       i686: '7245cfaa6b1d4dbfd0b495b0a78a4b0969002d67e118184e887a2347328c12c4',
     x86_64: 'f3e5350af96d7c6785b06f260bbc66a96568118739ae737cd98d91e9cfcc49ca'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    # remove font tools dependent tests
    system "sed -i '/cmptest/d' tests/CMakeLists.txt"
  end

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_LIBSUFFIX_OPTIONS} -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
