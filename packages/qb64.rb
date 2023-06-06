require 'package'

class Qb64 < Package
  description 'QB64 is a modern extended BASIC+OpenGL language that retains QB4.5/QBasic compatibility and compiles native binaries for Windows, Linux and macOS.'
  homepage 'https://www.qb64.org/'
  version '1.2'
  license 'MIT, custom, BSD-2, LGPL-2.1, LGPL-2 and GPL-2 or FTL'
  compatibility 'all'
  source_url 'https://www.qb64.org/autobuilds/master/qb64_2018-02-28-12-16-57_c3ad985-master_lnx.tar.gz'
  source_sha256 '47c739847e3f0d517150eae28e459e4c2cc1f904c1ab11eb7d089810d56e044a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qb64/1.2_armv7l/qb64-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qb64/1.2_armv7l/qb64-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qb64/1.2_i686/qb64-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qb64/1.2_x86_64/qb64-1.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '52da6cf27545c7274592622927df205de268cbd8f4be87c75ff845ec68120cd4',
     armv7l: '52da6cf27545c7274592622927df205de268cbd8f4be87c75ff845ec68120cd4',
       i686: '7aef527455b9dcf70438665b901d0e5f80e57e1ad9079cf767397476338355d8',
     x86_64: 'f93227d12bceb6248131ceecd2d542c995a4476185c6bb1f00095135879acf49'
  })

  depends_on 'alsa_lib'
  depends_on 'alsa_plugins'
  depends_on 'freeglut'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglu'
  depends_on 'libx11' # R
  depends_on 'mesa' # R
  depends_on 'sommelier'

  def self.patch
    system "find . -name '*.sh' -exec sed -i \"s/\\r//g\" {} \\;"
    system "find . -name '*.sh' -exec sed -i \"s/\.\\/setup/bash setup/g\" {} \\;"
    system "find . -name '*.sh' -exec sed -i \"s/\.\\/qb64 \\&/exec qb64 \\&/g\" {} \\;"
    system "find . -name '*.sh' -exec sed -i \"s/\~\\/\.local\\/share\\/applicationexec qb64\\.desktop/\\/dev\\/null/g\" {} \\;"
    case ARCH
    when 'armv7l', 'aarch64'
      system "sed -i '1i#define QB64_NOT_X86' internal/c/common.h"
    end
  end

  def self.build
    system 'bash setup_lnx.sh'
  end

  def self.install
    system 'chmod', '+x', 'qb64'
    system 'mkdir', '-p', "#{CREW_DEST_PREFIX}/share/qb64"
    system 'mkdir', '-p', "#{CREW_DEST_PREFIX}/bin"
    system 'cp', '-rpa', '.', "#{CREW_DEST_PREFIX}/share/qb64/"
    system "echo '\#!/bin/bash' >> #{CREW_DEST_PREFIX}/bin/qb64"
    system "echo \"cd #{CREW_PREFIX}/share/qb64/\" >> #{CREW_DEST_PREFIX}/bin/qb64"
    system "echo \"sommelier -X #{CREW_PREFIX}/share/qb64/qb64\" >> #{CREW_DEST_PREFIX}/bin/qb64"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/qb64"
  end
end
