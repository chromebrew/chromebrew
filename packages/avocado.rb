require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '67.0'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado/archive/67.0.tar.gz'
  source_sha256 'ae96466e2c19da3c6044ae59e05b235f6d211cfc4de8cbecfcaf0b59dc61332a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-67.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-67.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-67.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-67.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c97be359f822af9643b4f86d6a93a8aa265effb8c1deac27af29a744601164cf',
     armv7l: 'c97be359f822af9643b4f86d6a93a8aa265effb8c1deac27af29a744601164cf',
       i686: '71b3af54c49600bf58255368944300017cef12af75b2c2775515719dd5a40a7a',
     x86_64: '4946b467cfb4366ac950edbdd57b3d45780a560659f50677e45c95095e101500',
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'setuptools'

  def self.install
    system "pip install avocado-framework --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/avocado"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/avocado-rest-client"
    avocado_home = "#{CREW_DEST_HOME}/.config/avocado"
    system "mkdir -p #{avocado_home}/data"
    system "touch #{avocado_home}/data/empty"
    system "mkdir -p #{avocado_home}/job-results"
    system "touch #{avocado_home}/job-results/empty"
    Dir.chdir "#{avocado_home}" do
      avocado_lib = "#{CREW_PREFIX}/lib/python2.7/site-packages/avocado/etc/avocado"
      system "ln -sf #{avocado_lib}/avocado.conf avocado.conf"
      system "ln -sf #{avocado_lib}/conf.d conf.d"
      system "ln -sf #{avocado_lib}/scripts scripts"
      system "ln -sf #{avocado_lib}/sysinfo sysinfo"
    end
    Dir.chdir "#{CREW_DEST_PREFIX}/lib/python2.7/site-packages/avocado/etc/avocado" do
      system "sed -i 's,/etc,~/.config,' avocado.conf"
      system "sed -i 's,/var/lib,~/.config,' avocado.conf"
      system "sed -i 's,/usr/share/doc,~/.config,' avocado.conf"
      system "sed -i 's,~/avocado,~/.config/avocado,' avocado.conf"
      system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' conf.d/gdb.conf"
      system "sed -i 's,/etc,~/.config,' conf.d/jobscripts.conf"
    end
  end

  def self.postinstall
    puts
    puts "To configure avocado, edit ~/.config/avocado/avocado.conf".lightblue
    puts
  end
end
