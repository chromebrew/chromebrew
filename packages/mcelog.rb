require 'package'

class Mcelog < Package
  description 'logs and accounts machine checks (in particular memory, IO, and CPU hardware errors) on modern x86 Linux systems.'
  homepage 'https://www.mcelog.org/'
  version '165'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git/snapshot/mcelog-165.tar.gz'
  source_sha256 'a18fdef9cfe2dfaefa09087c616c376a301dc87b1fa14a37476d97370962c668'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mcelog/165_armv7l/mcelog-165-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mcelog/165_armv7l/mcelog-165-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mcelog/165_i686/mcelog-165-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mcelog/165_x86_64/mcelog-165-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5d9cf717ea6e8f1008b061468130164e14794588d1bf5610d01563cf48182c9b',
     armv7l: '5d9cf717ea6e8f1008b061468130164e14794588d1bf5610d01563cf48182c9b',
       i686: '9d5f57770c2189457f402992ef0fa08ccf26d9db677ec725177589ec92b32118',
     x86_64: 'cbe973fe9210ca821f3bda8e2f0f98249ab8fa4043fcf30fdb7ef5a1c234362b'
  })

  def self.patch
    system "sed -i 's,prefix := /usr,prefix := #{CREW_PREFIX},' Makefile"
    system "sed -i 's,etcprefix :=,etcprefix := #{CREW_PREFIX},' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
