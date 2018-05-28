require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '1.2'

  is_fake

  if File.exist? CREW_CONFIG_PATH + "meta/glibc219.filelist"
      conflict_solve = "`crew remove glibc219`"
  else
      depends_on 'glibc223'
  end
  if File.exist? CREW_CONFIG_PATH + "meta/glibc223.filelist"
      conflict_solve = "`crew remove glibc223`"
  else
    depends_on 'glibc223'
  end

  # Check old glibc
  if File.exist? CREW_CONFIG_PATH + "meta/glibc.filelist"
    if File.exist? CREW_CONFIG_PATH + "meta/glibc227.filelist"
      # Already installed old glibc and glibc227, so need to remove both once
      conflict_solve = "`crew remove glibc227 glibc`"
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
