require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '1.2'

  is_fake

  # Check old glibc
  if File.exist? CREW_CONFIG_PATH + "meta/glibc.filelist"
    if File.exist? CREW_CONFIG_PATH + "meta/glibc219.filelist"
      # Already installed old glibc and glibc219, so need to remove both once
      conflict_solve = "`crew remove glibc219 glibc`"
    else
      # Already installed old glibc, so need it once
      conflict_solve = "`crew remove glibc`"
    end
  else
    case CHROMEOS_RELEASE
    when '67', '68', '69'
      depends_on 'glibc227'
    else
      depends_on 'glibc223'
  end

  if File.exist? CREW_CONFIG_PATH + "meta/glibc223.filelist"
    # Already installed old glibc version 2.23, so need to remove
    conflict_solve = "`crew remove glibc223`"
  end

  if conflict_solve
    puts
    puts "In order to install/upgrade glibc, please execute #{conflict_solve} first".lightblue
    puts
    exit 1
  end
end
