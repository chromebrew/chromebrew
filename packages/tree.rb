require 'package'

class Tree < Package
  description 'Tree is a recursive directory listing command that produces a depth indented listing of files, which is colorized ala dircolors if the LS_COLORS environment variable is set and output is to tty.'
  homepage 'http://mama.indstate.edu/users/ice/tree/'
  version '2.1.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://mama.indstate.edu/users/ice/tree/src/tree-2.1.0.tgz'
  source_sha256 '0160c535bff2b0dc6a830b9944e981e3427380f63e748da96ced7071faebabf6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3bcf4c520da9ece2bfafe91dc60a3aef3d082748bb97831b6dc11435d5bb3a9d',
     armv7l: '3bcf4c520da9ece2bfafe91dc60a3aef3d082748bb97831b6dc11435d5bb3a9d',
       i686: 'ed51e27c703299efd1b73221c6c5226d2b0d10c629dac2326d1edc6a9258867f',
     x86_64: 'a99cb6010fc11eb1802b1307b9e486104f74745baed92b8764b7f2055ea908f6'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_PREFIX}/bin", "MANDIR=#{CREW_DEST_MAN_PREFIX}", 'install'
  end
end
