require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '1.1'

  is_fake

  if (File.exist? "/lib/libc-2.23.so") || (File.exist? "/lib64/libc-2.23.so")
    depends_on 'glibc223'
    # Check previous version
    if File.exist? CREW_CONFIG_PATH + "meta/glibc219.filelist"
      conflict_solve = "`crew remove glibc219`"
    end
  else
    depends_on 'glibc219'
  end

  # Check old glibc
  if File.exist? CREW_CONFIG_PATH + "meta/glibc.filelist"
    if File.exist? CREW_CONFIG_PATH + "meta/glibc223.filelist"
      # Already installed old glibc and glibc223, so need to remove both once
      conflict_solve = "`crew remove glibc223 glibc`"
    else
      # Already installed old glibc, so need it once
      conflict_solve = "`crew remove glibc`"
    end
  end

  if conflict_solve
    puts
    puts "In order to install/upgrade glibc, please execute #{conflict_solve} first".lightblue
    puts
    exit 1
  end
end
