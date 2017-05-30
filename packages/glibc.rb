require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '1.0'

  is_fake

  if (File.exist? "/lib/libc-2.23.so") || (File.exist? "/lib64/libc-2.23.so")
    depends_on 'glibc223'
    # Check previous version
    if File.exist? CREW_CONFIG_PATH + "meta/glibc219.filelist"
      conflict_solve = "`sudo crew remove glibc219`"
    end
  else
    depends_on 'glibc219'
  end

  # Check old glibc
  if File.exist? CREW_CONFIG_PATH + "meta/glibc.filelist"
    if File.exist? CREW_CONFIG_PATH + "meta/glibc223.filelist"
      # Already installed old glibc and glibc223, so need to remove both once
      conflict_solve = "`sudo crew remove glibc223` AND `sudo crew remove glibc`"
    else
      # Already installed old glibc, so need it once
      conflict_solve = "`sudo crew remove glibc`"
    end
  end

  if conflict_solve
    puts
    puts "IN ORDER TO INSTALL/UPGRADE GLIBC, PLEASE PERFORMS #{conflict_solve} FIRST"
    puts
    exit 1
  end
end
