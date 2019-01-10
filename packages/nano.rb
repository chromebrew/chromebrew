require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '3.2-1'
  source_url 'https://www.nano-editor.org/dist/v3/nano-3.2.tar.xz'
  source_sha256 'd12773af3589994b2e4982c5792b07c6240da5b86c5aef2103ab13b401fe6349'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-3.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'db96c75313fda53faea0e9a0ee4690f9f24079fc457c48e09626ac1651ee18ca',
     armv7l: 'db96c75313fda53faea0e9a0ee4690f9f24079fc457c48e09626ac1651ee18ca',
       i686: '0715e4858cd3eecfaaee253d7a720f35b57bfb25f9cb0c1f845f65f69fbfe4be',
     x86_64: '1c7fef9ce6e3d4a3a1e77824dba8f8ac3f96bcb6c581faf8ae5092186923e091',
  })

  depends_on 'xdg_base'

  def self.patch
    system "sed -i '/SIGWINCH/d' src/nano.c"
  end

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--enable-utf8"
    system 'make'
    open('nanorc', 'w') { |f|
      f << "set constantshow\n"
      f << "set fill 72\n"
      f << "set historylog\n"
      f << "set multibuffer\n"
      f << "set nowrap\n"
      f << "set positionlog\n"
      f << "set historylog\n"
      f << "set quickblank\n"
      f << "set regexp\n"
      f << "set smooth\n"
      f << "set suspend\n"
    }
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
    system "install -Dm644 nanorc #{CREW_DEST_HOME}/.nanorc"
    # Fix Unable to create directory /home/chronos/user/.local/share/nano/: No such file or directory
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.local/share"
    system "ln -sf #{CREW_PREFIX}/share/nano #{CREW_DEST_HOME}/.local/share/nano"
  end

  def self.postinstall
    puts
    puts "Personal configuration file is located in $HOME/.nanorc".lightblue
    puts
    puts "To make nano your default editor, execute the following:".lightblue
    puts
    puts "echo 'EDITOR=#{CREW_PREFIX}/bin/nano' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
  end
end
