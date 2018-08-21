require 'package'

class Qb64 < Package
  description 'QB64 is a modern extended BASIC+OpenGL language that retains QB4.5/QBasic compatibility and compiles native binaries for Windows, Linux and macOS.'
  homepage 'https://www.qb64.org/'
  version '1.2'
  source_url 'https://www.qb64.org/autobuilds/master/qb64_2018-02-28-12-16-57_c3ad985-master_lnx.tar.gz'
  source_sha256 '47c739847e3f0d517150eae28e459e4c2cc1f904c1ab11eb7d089810d56e044a'

  depends_on 'libglu'
  depends_on 'freeglut'
  depends_on 'alsa_lib'
  depends_on 'alsa_plugins'
  depends_on 'sommelier'

  def self.build
    system "find . -name '*.sh' -exec sed -i \"s/\\r//g\" {} \\;"
    system "find . -name '*.sh' -exec sed -i \"s/\.\\/setup/bash setup/g\" {} \\;"
    system "find . -name '*.sh' -exec sed -i \"s/\.\\/qb64 \\&/exec qb64 \\&/g\" {} \\;"
    system "find . -name '*.sh' -exec sed -i \"s/\~\\/\.local\\/share\\/applicationexec qb64\\.desktop/\\/dev\\/null/g\" {} \\;"
    system "sed -i '1i#define QB64_NOT_X86' internal/c/common.h" if ARCH == 'armv7l' || ARCH == 'aarch64'
    system "bash setup_lnx.sh"
  end

  def self.install
    system "chmod", "+x", "qb64"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/qb64"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "cp", "-rpa", ".", "#{CREW_DEST_PREFIX}/share/qb64/"
    system "echo '\#!/bin/bash' >> #{CREW_DEST_PREFIX}/bin/qb64"
    system "echo \"cd #{CREW_PREFIX}/share/qb64/\" >> #{CREW_DEST_PREFIX}/bin/qb64"
    system "echo \"sommelier -X #{CREW_PREFIX}/share/qb64/qb64\" >> #{CREW_DEST_PREFIX}/bin/qb64"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/qb64"
  end
end
