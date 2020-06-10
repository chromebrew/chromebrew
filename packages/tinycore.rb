require 'package'

class Tinycore < Package
  description 'TinyCore Linux is a distro based on loop-device mounted programs, like Snaps.
          This is a wrapper script to be able to execute their .tcz files.'
  homepage 'https://distro.ibiblio.org/tinycorelinux/'
  compatibility 'all'
  version '9.0-0'
  case ARCH
  when 'armv7l', 'aarch64'
    source_url 'https://distro.ibiblio.org/tinycorelinux/9.x/armv7/tcz/bash.tcz'
    source_sha256 '8f67e85cad963dd859086429f4a31cdd79b89ae0d84379018085dfbb62d0d3a7'
  when 'i686'
    source_url 'https://distro.ibiblio.org/tinycorelinux/9.x/x86/tcz/bash.tcz'
    source_sha256 '53fd575388ccfee58b4a4fdc43263e73c263b612f3bae67e22dafa5da4f61530'
  when 'x86_64'
    source_url 'https://distro.ibiblio.org/tinycorelinux/9.x/x86_64/tcz/bash.tcz'
    source_sha256 'cbc2f97c8b8dada90ec3cf99b328ec73c1b0fa9cc2cb594d273fd7b118610d49'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    case ARCH
    when 'x86_64'
      system "echo '#!/bin/bash

set -e

export PKG=`echo $\{1%%.*\}`
export BIN=`echo $1|sed \"s/^[^\.]*\.//\"`
export OPT=`shift; echo $@`

[ -d #{CREW_PREFIX}/share/tinycore/$PKG ] || { echo Package $PKG not found. && exit 1; }
[ -e #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN ] || { echo Program $BIN not found. && exit 1; }
if file #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN | grep \"text executable\" &>/dev/null; then
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{CREW_PREFIX}/share/tinycore/$PKG/usr/local/lib #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN $OPT
else
  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{CREW_PREFIX}/share/tinycore/$PKG/usr/local/lib /#{ARCH_LIB}/ld-linux-x86-64.so.2 #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN $OPT
fi
' > tinycore" 
    else
    system "echo '#!/bin/bash

set -e

export PKG=`echo $\{1%%.*\}`
export BIN=`echo $1|sed \"s/^[^\.]*\.//\"`
export OPT=`shift; echo $@`

[ -d #{CREW_PREFIX}/share/tinycore/$PKG ] || { echo Package $PKG not found. && exit 1; }
[ -e #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN ] || { echo Program $BIN not found. && exit 1; }
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{CREW_PREFIX}/share/tinycore/$PKG/usr/local/lib #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN $OPT
' > tinycore"
    end
    system "chmod a+x tinycore"
    system "cp ../bash.tcz ."
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tinycore/examples"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tinycore/bash"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "cp -pa tinycore #{CREW_DEST_PREFIX}/bin/"
    system "cp -pa bash.tcz #{CREW_DEST_PREFIX}/share/tinycore/examples/"
  end

  def self.postinstall
    puts
    puts "Examples are located at #{CREW_PREFIX}/share/tinycore/examples/".lightblue
    puts "To try TinyCore Bash, please execute:".lightblue
    puts "sudo mount -o loop #{CREW_PREFIX}/share/tinycore/examples/bash.tcz #{CREW_PREFIX}/share/tinycore/bash/".lightblue
    puts "tinycore bash.bash".lightblue
    puts "sudo umount #{CREW_PREFIX}/share/tinycore/bash/".lightblue
    puts
    puts "The executable names are in the format of Snap executable names.".lightblue
    puts "This is imperative to be able to run TinyCore programs.".lightblue
    puts "For eample, to run the 'bashbug' program in the TinyCore 'bash' package, please execute:".lightblue
    puts "tinycore bash.bashbug".lightblue
    puts
    puts "To run a binary that has a dot in its name, such as 'ld.gold', use the full name:".lightblue
    puts "tinycore binutils.ld.gold".lightblue
    puts
  end
end
