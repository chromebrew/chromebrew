require 'package'

class Ladspa < Package
  description 'Linux Audio Developer\'s Simple Plugin API'
  homepage 'https://www.ladspa.org/'
  version '1.15'
  source_url 'https://www.ladspa.org/download/ladspa_sdk_1.15.tgz'
  source_sha256 '4229959b09d20c88c8c86f4aa76427843011705df22d9c28b38359fd1829fded'

  def self.patch
    Dir.chdir('src') do
      system 'sed', '-i', '-e', "s,/usr,\$(DESTDIR)#{CREW_PREFIX},g", '-e', "s,lib,#{ARCH_LIB},", 'Makefile'
    end
  end

  def self.build
    Dir.chdir('src') do
      system 'make'
    end
  end

  def self.install
    Dir.chdir('src') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
