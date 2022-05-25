require 'package'

class Fpc < Package
  description 'Free Pascal is a 32, 64 and 16 bit professional Pascal compiler.'
  homepage 'https://www.freepascal.org/'
  version '3.2.2'
  license 'GPL-2 and LGPL-2.1-with-linking-exception'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://downloads.sourceforge.net/project/freepascal/Linux/3.2.2/fpc-3.2.2.arm-linux.tar'
    source_sha256 '971bbcaa1934286ccdaf3998d338afc19a33235e910f8881c75579ed5d6adefd'
  when 'i686'
    source_url 'https://downloads.sourceforge.net/project/freepascal/Linux/3.2.2/fpc-3.2.2.i386-linux.tar'
    source_sha256 'f62980ac0b2861221f79fdbff67836aa6912a4256d4192cfa4dfa0ac5b419958'
  when 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/freepascal/Linux/3.2.2/fpc-3.2.2.x86_64-linux.tar'
    source_sha256 '5adac308a5534b6a76446d8311fc340747cbb7edeaacfe6b651493ff3fe31e83'
  end
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fpc/3.2.2_armv7l/fpc-3.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fpc/3.2.2_armv7l/fpc-3.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fpc/3.2.2_i686/fpc-3.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fpc/3.2.2_x86_64/fpc-3.2.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '84701dedbee28a6db2386366318a8c2e27c389a758ea8033502d40fa2f4ec588',
     armv7l: '84701dedbee28a6db2386366318a8c2e27c389a758ea8033502d40fa2f4ec588',
       i686: '20062e277f6432b76115a74b6b46a38888ef696f15bbf79efce8546a1aff9a46',
     x86_64: 'b5b9152ce23f5e7f33ab8b788ef80ca440d2d26ef300321f1e944c24051f9b45'
  })

  def self.patch
    system "sed -i 's,PREFIX=\"\$HOME/fpc-\$VERSION\",PREFIX=#{CREW_DEST_PREFIX},' install.sh"
    system "sed -i 's,\$PREFIX/lib,#{CREW_DEST_LIB_PREFIX},' install.sh"
  end

  def self.install
    system './install.sh'
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/fpc/#{version}/ppcarm", "#{CREW_DEST_PREFIX}/bin/ppcarm"
    FileUtils.mv "#{CREW_DEST_PREFIX}/man", CREW_DEST_MAN_PREFIX
  end

  def self.postinstall
    puts "\nType 'fp' to start.\n".lightblue
  end

  def self.remove
    print 'Would you like to remove the config directories? [y/N] '
    response = $stdin.gets.chomp.downcase
    config_dirs = ["#{HOME}/.fpc.cfg", "#{HOME}/.config/fppkg.cfg", "#{HOME}/.fppkg"]
    config_dirs.each do |config_dir|
      case response
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
