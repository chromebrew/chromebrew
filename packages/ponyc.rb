require 'package'

class Ponyc < Package
  description 'Pony is an open-source, object-oriented, actor-model, capabilities-secure, high-performance programming language.'
  homepage 'https://www.ponylang.io/'
  version '0.59.0'
  license 'BSD-2 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/ponylang/ponyc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'f5eb097d4ad790df38f1d699fd1daa672448fd8302b08ad4c18e839baba91919'
  })

  depends_on 'cmake' => :build
  depends_on 'gcc_lib' # R
  depends_on 'llvm' => :build
  depends_on 'python3' # R

  def self.patch
    # No need for symlinks.
    system "sed -i '307,318d' Makefile"
    # Remove tests/full-program-runner.
    system "sed -i '299d' CMakeLists.txt"
    # Fix destination paths.
    system "sed -i 's,\$(ponydir)/lib/\$(arch),#{CREW_DEST_LIB_PREFIX},g' Makefile"
    system "sed -i 's,\$(ponydir),#{CREW_DEST_PREFIX},g' Makefile"
  end

  def self.build
    system 'make libs'
    system 'make configure'
    system 'make build'
  end

  def self.install
    system 'make install'
    # Conform to FHS compliance.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ponyc"
    FileUtils.mv "#{CREW_DEST_PREFIX}/packages", "#{CREW_DEST_PREFIX}/share/ponyc"
  end

  def self.postinstall
    ExitMessage.add "\nType 'ponyc -h' to get started.\n"
  end
end
