require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'https://github.com/Old-Man-Programmer/tree'
  version '2.3.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Old-Man-Programmer/tree.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84ff9b60bcede803498c651bccd3341ac0aa25be94c073432c3e8285e0d41c9a',
     armv7l: '84ff9b60bcede803498c651bccd3341ac0aa25be94c073432c3e8285e0d41c9a',
       i686: '8c6cde46e4f369914e8ef850d7538b5f57e5a268edd197085550be401a343f5c',
     x86_64: 'dd260b9ffc4dc3a68c55ff723d70830217f65e537e3c30d2441be8c3197325af'
  })

  depends_on 'glibc' => :library

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_MAN_PREFIX}", 'install'
  end
end
