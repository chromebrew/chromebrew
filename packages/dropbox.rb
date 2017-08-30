require 'package'

class Dropbox < Package
  description 'Dropbox simplifies the way you create, share and collaborate.  Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '32.4.23-1'
  case ARCH
  when 'i686'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86-32.4.23.tar.gz'
    source_sha256 'd7e130f2872fb2d141f8d2f892f7a2c29b95ccd3620398c21ea53dee878dc075'
  when 'x86_64'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86_64-32.4.23.tar.gz'
    source_sha256 'a18dca750e72e0604b9798bfe5e0b9b7a2b5ed43116ab96166a298ae3c1b5086'
  else
    puts 'Unable to install dropboxd.  Supported architectures include i686 and x86_64 only.'.lightred
  end

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox-32.4.23-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox-32.4.23-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '9b1223d26c8d93a9e1b981bb0746fcb2053c175caaa57494af9de779551ffb7b',
     x86_64: '372981c324e128d2b9df037c1c8413c9e7a055aae3267954cd9f213cf00c8f16',
  })

  depends_on 'python27' unless File.exists? '/usr/local/bin/python'

  def self.build
    system "wget https://linux.dropbox.com/packages/dropbox.py"
    system "sed -i 's,~/.dropbox-dist,#{CREW_LIB_PREFIX}/dropbox,g' dropbox.py"
    system "echo '#!/bin/bash' > dropbox"
    system "echo 'python #{CREW_PREFIX}/bin/dropbox.py \"\$@\"' >> dropbox"
    system "chmod +x dropbox"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/dropbox"
    system "cp -r .dropbox-dist/* #{CREW_DEST_LIB_PREFIX}/dropbox"
    system "cp dropbox.py #{CREW_DEST_PREFIX}/bin"
    system "cp dropbox #{CREW_DEST_PREFIX}/bin"
  end
end
