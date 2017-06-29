require 'package'

class Dropbox < Package
  description 'Dropbox simplifies the way you create, share and collaborate. Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '28.4.14'
  case ARCH
  when 'i686'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86-28.4.14.tar.gz'
    source_sha256 '8ab28710d819ad2f790a7f5d5132a58d28ea9751f2f04f234bc1f9f9979c5c83'
  when 'x86_64'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86_64-28.4.14.tar.gz'
    source_sha256 'a2385e48ab8ea8403f5c51c297105019a90cb58773bf383c6205bd3586a7ee0a'
  end

  depends_on 'python' unless File.exists? '/usr/local/bin/python'

  def self.install
    system "wget https://linux.dropbox.com/packages/dropbox.py"
    system "sed -i 's,~/.dropbox-dist,/usr/local/bin,g' dropbox.py"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp -r .dropbox-dist/. #{CREW_DEST_DIR}/usr/local/bin"
    system "echo '#!/bin/bash' > dropbox"
    system "echo 'python /usr/local/bin/dropbox.py \$1' >> dropbox"
    system "chmod +x dropbox"
    system "cp dropbox.py #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dropbox #{CREW_DEST_DIR}/usr/local/bin"
  end
end
