require 'package'

class Progress < Package
  description 'Linux tool to show progress for cp, mv, dd, ... (formerly known as cv)'
  homepage 'https://github.com/Xfennec/progress'
  version '0.17'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/Xfennec/progress.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccf78177403c3439e83ccc0e77375d319376c2a058752a05f51879c0036227e9',
     armv7l: 'ccf78177403c3439e83ccc0e77375d319376c2a058752a05f51879c0036227e9',
       i686: 'aa3a404e8f21c01ff3ad0c3ecd754988029776815810c91d8f374bb3dfa02dfd',
     x86_64: '94a956dedd7218294a708f02e4c1471c6942d5504c93950dc798856b7460fa65'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'pkgconf' => :build

  def self.build
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX ?= #{CREW_PREFIX},' Makefile"
    system "make CFLAGS=' -I#{CREW_PREFIX}/include/ncurses'"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
