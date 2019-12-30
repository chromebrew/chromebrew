require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.41.1'
  source_url 'https://github.com/VSCodium/vscodium/releases/download/1.41.1/VSCodium-linux-x64-1.41.1.tar.gz'
  source_sha256 '3d50cedad289730301ddbb6cc5f754753e3fc58b0c812da5390b2871c0639c58'

  binary_url ({
  })
  binary_sha256 ({
  })

  if ARGV[0] == 'install' || ARGV[0] == 'upgrade'
    abort "#{ARCH} architecture not supported.".lightred unless ARCH == 'x86_64'
  end

  @arch = 'x64'

  depends_on 'gtk2'
  depends_on 'libsecret'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/VSCodium-linux-#{@arch}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/VSCodium-linux-#{@arch}"
    FileUtils.ln_s "../share/VSCodium-linux-#{@arch}/bin/codium", "#{CREW_DEST_PREFIX}/bin/codium"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed VSCodium on Chrome OS!'.lightgreen
    puts 'Now, please type \'codium\' to execute.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
