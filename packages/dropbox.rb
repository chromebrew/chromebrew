require 'package'

class Dropbox < Package
  description 'Dropbox simplifies the way you create, share and collaborate. Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '30.4.22'
  case ARCH
  when 'i686'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86-30.4.22.tar.gz'
    source_sha256 '4b41ab4fae4b02a0428cbafccb45ecde82b2b3b774127826f1945f660e0ed47f'
  when 'x86_64'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86_64-30.4.22.tar.gz'
    source_sha256 '1928e49d91a5c039f4903c5bc12be032eb499fcc8352b6eb2a33b40b8d4c8961'
  else
    puts 'Unable to install dropboxd.  Supported architectures include x86 and x86_64 only.'.lightred
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
