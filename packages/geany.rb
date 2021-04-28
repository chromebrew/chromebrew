require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '1.37.1'
  license 'GPL-2+ HPND'
  compatibility 'all'
    source_url 'https://download.geany.org/geany-1.37.1.tar.bz2'
    source_sha256 '18c5756444c1d8bcd737c8ecfd4ef0b3607c924fc02560d4e8b78f6121531a18'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1_armv7l/geany-1.37.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1_armv7l/geany-1.37.1-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1_i686/geany-1.37.1-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1_x86_64/geany-1.37.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '23569bccfea77b83925f8d8b69b0726956fab967588f8b87433a9aec9e846f9c',
      armv7l: '23569bccfea77b83925f8d8b69b0726956fab967588f8b87433a9aec9e846f9c',
        i686: '7a8600c481502fabad7079513381b21b9d3d628bcbc9c24d59ef3825e3b49459',
      x86_64: '02fb7bbd757af647903507b68d880a5207c3666725f49748edb1e71c0c629a51',
  })

    depends_on 'gtk3'
    depends_on 'xdg_base'
    depends_on 'sommelier'


  def self.build
    system "./configure #{CREW_OPTIONS} --enable-api-docs=no --enable-html-docs=no --enable-pdf-docs=no"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "To get started, type 'geany'.".lightblue
    puts
    puts "To completely uninstall, execute the following:".lightblue
    puts "crew remove geany".lightblue
    puts "rm -rf ~/.config/geany".lightblue
    puts
  end
end
