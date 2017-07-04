require 'package'

class Gdrive < Package
  description 'Google Drive CLI Client'
  homepage 'https://www.google.com/drive/'
  version '2.1.0'

  source_url 'https://github.com/prasmussen/gdrive/archive/2.1.0.tar.gz'
  source_sha256 'a1ea624e913e258596ea6340c8818a90c21962b0a75cf005e49a0f72f2077b2e'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    case ARCH
    when 'aarch64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnRjBaMVVLalN4cTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '25eb74f892785bfd7c93ec22e63dfce04fd68298d8449ea1473bdbf90e3aaf35'
    when 'armv7l'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnRjBaMVVLalN4cTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '25eb74f892785bfd7c93ec22e63dfce04fd68298d8449ea1473bdbf90e3aaf35'
    when 'i686'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnLV92dHBpTkFhTEU&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == '768103053ebe56d5b6e17396ac208db85a3b1968d19e9cac9172fe56b6b8cad2'
    when 'x86_64'
      system "wget -L -O #{CREW_DEST_DIR}/usr/local/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_DIR}/usr/local/bin/gdrive") ) == 'f31b441c5cdb835ee69849a62856e35c17954fd5b600f6de8a6f5d7bd7bf0420'
    end
    system "chmod +x #{CREW_DEST_DIR}/usr/local/bin/gdrive"
  end
end
