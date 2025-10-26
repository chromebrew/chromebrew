require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'https://github.com/Old-Man-Programmer/tree'
  version '2.2.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Old-Man-Programmer/tree.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee1ffe8304e20d04ab323c44c85956438d2478be886734bac9e3a90800cf0f1b',
     armv7l: 'ee1ffe8304e20d04ab323c44c85956438d2478be886734bac9e3a90800cf0f1b',
       i686: '61479f4b2831ec6927c4c81352988b2c0d20b1923667e605cb08bb41d6b98dd9',
     x86_64: '1f1de80fc668ace74490a1a2ec74c6408de42223feb3ba7afbb11b4f0f6dc621'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_MAN_PREFIX}", 'install'
  end
end
