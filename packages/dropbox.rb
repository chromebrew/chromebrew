require 'package'

class Dropbox < Package
  description 'Dropbox simplifies the way you create, share and collaborate. Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '29.4.20'
  case ARCH
  when 'i686'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86-29.4.20.tar.gz'
    source_sha256 'd3d51259a4dae434c10f9c352aa2a3f75a98ffbfb04dfab8c182cff7e3b5ed7d'
  when 'x86_64'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86_64-29.4.20.tar.gz'
    source_sha256 '82321e3955b8d6dc329fe1fa9f4eb17a88e1beeac9eae8874318574310461671'
  end

  depends_on 'python' unless File.exists? '/usr/local/bin/python'

  def self.install
    system "wget https://linux.dropbox.com/packages/dropbox.py"
    system "sed -i 's,~/.dropbox-dist,/usr/local/bin,g' dropbox.py"
    system "echo '#!/bin/bash' > dropbox"
    system "echo 'python /usr/local/bin/dropbox.py \$1' >> dropbox"
    system "chmod +x dropbox"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp -r .dropbox-dist/. #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dropbox.py #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dropbox #{CREW_DEST_DIR}/usr/local/bin"
  end
end
