require 'package'

class Gdrive < Package
  description 'Google Drive CLI Client'
  homepage 'https://www.google.com/drive/'
  version '2.1.0'

  source_url 'https://github.com/prasmussen/gdrive/archive/2.1.0.tar.gz'
  source_sha1 '2abfb27e9c0bfa1904bcfb6bd01b32ed6884db75'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    case ARCH
    when 'x86_64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
    when 'armv7l'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnamliN0Rld01oRVk&export=download"
    when 'mips64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6Embna2lzdEJ6blFzSzQ&export=download"
    when 'ppc64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnS09XMzhfRXBnUzA&export=download"
    else
      abort 'Unable to install gdrive.  Architecture not supported.'.lightred
    end
    system "sleep 10"
    system "chmod +x #{CREW_DEST_DIR}/usr/local/bin/gdrive"
  end
end
