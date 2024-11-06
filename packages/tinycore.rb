require 'package'

class Tinycore < Package
  description 'TinyCore Linux is a distro based on loop-device mounted programs, like Snaps.
          This is a wrapper script to be able to execute their .tcz files.'
  homepage 'https://distro.ibiblio.org/tinycorelinux/'
  version '15.x'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: "https://distro.ibiblio.org/tinycorelinux/#{version}/armhf/tcz/bash.tcz",
     armv7l: "https://distro.ibiblio.org/tinycorelinux/#{version}/armhf/tcz/bash.tcz",
       i686: "https://distro.ibiblio.org/tinycorelinux/#{version}/x86/tcz/bash.tcz",
     x86_64: "https://distro.ibiblio.org/tinycorelinux/#{version}/x86_64//tcz/bash.tcz"
  })
  source_sha256({
    aarch64: '5d85920a8176cad9ac9b44bae85084d8ca30239fe1c7df3188753b4f64412782',
     armv7l: '5d85920a8176cad9ac9b44bae85084d8ca30239fe1c7df3188753b4f64412782',
       i686: 'eabe7d8ac11d07b1084863b36f0612b10639a63ea52946768f42cfbedf249c2a',
     x86_64: '898452acbf321a9a4e9f1386967123884ef8d97693262e2c2155454fcbddc160'
  })

  no_compile_needed

  def self.build
    case ARCH
    when 'x86_64'
      File.write 'tinycore', <<~EOF
        #!/bin/bash

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
      EOF
    else
      File.write 'tinycore', <<~EOF
        #!/bin/bash

        set -e

        export PKG=`echo $\{1%%.*\}`
        export BIN=`echo $1|sed \"s/^[^\.]*\.//\"`
        export OPT=`shift; echo $@`

        [ -d #{CREW_PREFIX}/share/tinycore/$PKG ] || { echo Package $PKG not found. && exit 1; }
        [ -e #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN ] || { echo Program $BIN not found. && exit 1; }
        LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{CREW_PREFIX}/share/tinycore/$PKG/usr/local/lib #{CREW_PREFIX}/share/tinycore/$PKG/usr/local/bin/$BIN $OPT
      EOF
    end
  end

  def self.install
    FileUtils.install 'tinycore', "#{CREW_DEST_PREFIX}/bin/tinycore", mode: 0o755
    FileUtils.install 'bash.tcz', "#{CREW_DEST_PREFIX}/share/tinycore/examples/bash.tcz", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM.lightblue

      Examples are located at #{CREW_PREFIX}/share/tinycore/examples/.

      To try TinyCore Bash, execute the following:
      sudo mount -o loop #{CREW_PREFIX}/share/tinycore/examples/bash.tcz #{CREW_PREFIX}/share/tinycore/bash/
      tinycore bash.bash
      sudo umount #{CREW_PREFIX}/share/tinycore/bash/

      The executable names are in the format of Snap executable names.
      This is imperative to be able to run TinyCore programs.
      For example, to run the 'bashbug' program in the TinyCore 'bash' package,  execute the following:
      tinycore bash.bashbug

      To run a binary that has a dot in its name, such as 'ld.gold', use the full name:
      tinycore binutils.ld.gold
    EOM
  end
end
