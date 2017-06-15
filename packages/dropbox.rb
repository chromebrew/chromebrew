require 'package'

class Dropbox < Package
  description 'Dropbox simplifies the way you create, share and collaborate. Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '28.4.14'
  case ARCH
  when 'x86'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86-28.4.14.tar.gz'
    source_sha1 '32f5e412b8f630c057bc4d4a8a034fe9af685ddc'
  when 'x86_64'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86_64-28.4.14.tar.gz'
    source_sha1 '40f4f37b64394d42f4fa3d6b3d53553f854587e4'
  else
    abort 'Unable to install dropboxd.  Supported architectures include x86 and x86_64 only.'.lightred
  end

  depends_on 'python'

  def self.install
    system "wget https://linux.dropbox.com/packages/dropbox.py"
    abort "Checksum mismatch. :/ Try again.".lightred unless Digest::SHA1.hexdigest( File.read("dropbox.py") ) == "de22fc6e68d5ff80885da032b79a8ad88f12d770"
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
