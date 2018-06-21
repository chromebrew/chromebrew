require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '1.2'

  is_fake

  if CHROMEOS_RELEASE <= '66'
    if (File.exist? '/lib/libc-2.23.so') || (File.exist? '/lib64/libc-2.23.so')
      # Check previous version
      if File.exist? CREW_CONFIG_PATH + 'meta/glibc219.filelist'
        system 'crew remove glibc219'
      end
      depends_on 'glibc223'
    end
  end
end
