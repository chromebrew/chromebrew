require 'package'

class Dmd < Package
  description 'D Programming Language compiler'
  homepage 'https://dlang.org/'
  version '2.102.1'
  license 'BSL-1.0'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dmd/2.102.1_x86_64/dmd-2.102.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '4a32b8ae822fc66fc26d6399d9d7db872ae72d8c97f2dde8606bc4defbbe760a'
  })

  depends_on 'ldc' => :build # For running dub in tests.

  def self.build
    system "git clone -b v#{version} https://github.com/dlang/dmd.git"
    Dir.chdir 'dmd' do
      system 'make -f posix.mak AUTO_BOOTSTRAP=1'
    end
    system "git clone -b v#{version} https://github.com/dlang/phobos.git"
    Dir.chdir 'phobos' do
      system 'make -f posix.mak'
    end
    system "git clone -b v#{version} https://github.com/dlang/tools.git"
    Dir.chdir 'tools' do
      system 'make -f posix.mak all'
    end
    conf = <<~EOF
      ;
      ; dmd.conf file for dmd
      ;
      ; dmd will look for dmd.conf in the following sequence of directories:
      ;   - current working directory
      ;   - directory specified by the HOME environment variable
      ;   - directory dmd resides in
      ;   - /etc directory
      ;
      ; Names enclosed by %% are searched for in the existing environment and inserted
      ;
      ; The special name %@P% is replaced with the path to this file
      ;

      [Environment32]
      DFLAGS=-I#{CREW_PREFIX}/include/phobos -I#{CREW_PREFIX}/include/dmd/druntime/import -L#{CREW_LIB_PREFIX}/i386-linux-gnu --export-dynamic -fPIC

      [Environment64]
      DFLAGS=-I#{CREW_PREFIX}/include/phobos -I#{CREW_PREFIX}/include/dmd/druntime/import -L#{CREW_LIB_PREFIX}/x86_64-linux-gnu --export-dynamic -fPIC
    EOF
    File.write('dmd.conf', conf)
  end

  def self.check
    # These tests take a LONG time to run.
    # Dir.chdir 'dmd' do
    #   system 'make -f posix.mak test AUTO_BOOTSTRAP=1'
    # end
    # Dir.chdir 'phobos' do
    #   system 'make -f posix.mak unittest AUTO_BOOTSTRAP=1'
    # end
    # Tests fail with Error: cannot find input file `/bin/sh.d`
    # Dir.chdir 'tools' do
    #   system 'make -f posix.mak test AUTO_BOOTSTRAP=1'
    # end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/phobos"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/dmd/druntime"
    FileUtils.install 'dmd/generated/linux/release/64/dmd', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.cp_r 'dmd/druntime/import', "#{CREW_DEST_PREFIX}/include/dmd/druntime"
    FileUtils.install 'dmd.conf', "#{CREW_DEST_PREFIX}/etc", mode: 0o644
    FileUtils.cp_r 'dmd/compiler/docs/man/man5', CREW_DEST_MAN_PREFIX
    Dir.chdir 'dmd/generated/linux/release/64/host_dmd-2.095.0/dmd2/man/man1' do
      FileUtils.install 'dmd.1', "#{CREW_DEST_MAN_PREFIX}/man1", mode: 0o644
    end
    Dir.chdir 'phobos/generated/linux/release/64' do
      libraries = %w[libphobos2.a libphobos2.so libphobos2.so.0.102 libphobos2.so.0.102.1]
      FileUtils.install libraries, CREW_DEST_LIB_PREFIX, mode: 0o644
    end
    FileUtils.cp_r ['phobos/etc', 'phobos/std'], "#{CREW_DEST_PREFIX}/include/phobos"
    Dir.chdir 'tools/generated/linux/64' do
      executables = %w[catdoc changed checkwhitespace contributors detab dget tolf updatecopyright]
      FileUtils.install executables, "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    end
  end
end
