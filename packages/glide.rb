require 'package'

class Glide < Package
  description 'Package Management for Golang'
  homepage 'https://glide.sh/'
  version '0.12.3'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/Masterminds/glide/releases/download/v0.12.3/glide-v0.12.3-linux-armv7.tar.gz'
    source_sha256 'cce4242c11d084f99087caaa0a42c8476a81db0cbcc83932f5821e1f29b7edb2'
  when 'i686'
    source_url 'https://github.com/Masterminds/glide/releases/download/v0.12.3/glide-v0.12.3-linux-386.tar.gz'
    source_sha256 '1f6fbcd84213c7c11a778ecd36d326d012f1a0555e6c0d6bf572dac7b80e8622'
  when 'x86_64'
    source_url 'https://github.com/Masterminds/glide/releases/download/v0.12.3/glide-v0.12.3-linux-amd64.tar.gz'
    source_sha256 '0e2be5e863464610ebc420443ccfab15cdfdf1c4ab63b5eb25d1216900a75109'
  end

  depends_on 'go'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp glide #{CREW_DEST_PREFIX}/bin"
  end
end
