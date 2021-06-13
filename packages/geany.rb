require 'package'

class Geany < Package
  description 'Geany is a small and lightweight Integrated Development Environment.'
  homepage 'https://www.geany.org/'
  version '1.37.1-b524'
  license 'GPL-2+ HPND'
  compatibility 'all'
  source_url 'https://github.com/geany/geany.git'
  git_hashtag 'b524a58e12e85c94a32f64fb72615978b2628af1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1-b524_armv7l/geany-1.37.1-b524-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1-b524_armv7l/geany-1.37.1-b524-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1-b524_i686/geany-1.37.1-b524-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geany/1.37.1-b524_x86_64/geany-1.37.1-b524-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4533890949b4dd456331fa10e2482ad59a93a28a43b9e413bacf22abab0f4fcc',
     armv7l: '4533890949b4dd456331fa10e2482ad59a93a28a43b9e413bacf22abab0f4fcc',
       i686: '8f49d7208ed72ca166b899b75031947b4e40fd8c9efcfb6cb91eb9b4df512de3',
     x86_64: '0b1870b7fc669a731d88ea4be18b5fba2ef7e233a5ffb1483aaa3cb3d710e78b'
  })

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --enable-api-docs=no \
      --enable-html-docs=no \
      --enable-pdf-docs=no"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    # This is needed to aoid "Error loading theme icon 'geany-build' for stock" messages.
    if File.exist?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
      system "gtk-update-icon-cache #{CREW_PREFIX}/share/icons/hicolor -f"
    end
    puts
    puts "To get started, type 'geany'.".lightblue
    puts
    puts 'To completely uninstall, execute the following:'.lightblue
    puts 'crew remove geany'.lightblue
    puts 'rm -rf ~/.config/geany'.lightblue
    puts
  end
end
