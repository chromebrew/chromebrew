require 'package'

class Gdrive < Package
  description 'Google Drive CLI Client'
  homepage 'https://www.google.com/drive/'
  version '2.1.0'
  compatibility 'all'
  source_url 'https://github.com/prasmussen/gdrive/archive/2.1.0.tar.gz'
  source_sha256 'a1ea624e913e258596ea6340c8818a90c21962b0a75cf005e49a0f72f2077b2e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdrive-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdrive-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdrive-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdrive-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6290b75162c27f422ccd8477d5dba46b94a91519f74f404f9edf7c44913cac4d',
     armv7l: '6290b75162c27f422ccd8477d5dba46b94a91519f74f404f9edf7c44913cac4d',
       i686: '393b9e31f9700fd6c986d1b1f633bc7b5c12f24ce0d6807a8c83b50ac2d55e5b',
     x86_64: 'dde5257e1686975cf1e4d0ffb2568eb0ea14fbc44f8cd7fae3a130afade5a854',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    case ARCH
    when 'aarch64'
      system "wget -L -O #{CREW_DEST_PREFIX}/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnRjBaMVVLalN4cTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_PREFIX}/bin/gdrive") ) == '25eb74f892785bfd7c93ec22e63dfce04fd68298d8449ea1473bdbf90e3aaf35'
    when 'armv7l'
      system "wget -L -O #{CREW_DEST_PREFIX}/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnRjBaMVVLalN4cTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_PREFIX}/bin/gdrive") ) == '25eb74f892785bfd7c93ec22e63dfce04fd68298d8449ea1473bdbf90e3aaf35'
    when 'i686'
      system "wget -L -O #{CREW_DEST_PREFIX}/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnLV92dHBpTkFhTEU&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_PREFIX}/bin/gdrive") ) == '768103053ebe56d5b6e17396ac208db85a3b1968d19e9cac9172fe56b6b8cad2'
    when 'x86_64'
      system "wget -L -O #{CREW_DEST_PREFIX}/bin/gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
      system "sleep 10"
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{CREW_DEST_PREFIX}/bin/gdrive") ) == 'f31b441c5cdb835ee69849a62856e35c17954fd5b600f6de8a6f5d7bd7bf0420'
    end
    system "chmod +x #{CREW_DEST_PREFIX}/bin/gdrive"
  end
end
