require 'buildsystems/autotools'

class Rsync < Autotools
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.4.3-907505c'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/RsyncProject/rsync'
  git_hashtag '907505c004ed6e43def6df657912158c597a0b63'
  # source_url "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"
  # source_sha256 'c72e63ca3021cbc80ba86ec30102773f4c5631fbc492b52e773b3958f82a53d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e1652281b3489309385aede912c5bbd4299bf22f6b06b72200c32c9881cb208',
     armv7l: '2e1652281b3489309385aede912c5bbd4299bf22f6b06b72200c32c9881cb208',
       i686: 'e7707617af4f593a3cc8e369b1a29fd7cc5b87b40853c2fb086fdbe7c5cbd13e',
     x86_64: '0efdd728cf3befef029e23f853435a988c7f4333c21ed86246520ba760263665'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'lz4' => :executable
  depends_on 'openssl' => :executable
  depends_on 'popt' => :executable
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' => :executable
  depends_on 'zstd' => :executable

  # tests broken by https://github.com/RsyncProject/rsync/pull/925.diff"
  run_tests unless version.include?('3.4.3')

  def self.patch
    patch = [
      # Fixes requirement of post kernel 5.6 linux/openat2.h
      # introduced by https://github.com/RsyncProject/rsync/pull/887
      # See https://github.com/RsyncProject/rsync/issues/924
      [
        'https://github.com/RsyncProject/rsync/pull/925.diff',
        'f84957e50a52b3580af8727b81b130db60c39024541c67b7c62a6d60c7514a1c'
      ]
    ]
    ConvenienceFunctions.patch(patch) if version.include?('3.4.3')
  end
end
